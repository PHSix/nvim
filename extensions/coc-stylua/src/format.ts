import { spawn } from 'node:child_process'
import { resolve } from 'node:path'
import { access } from 'node:fs'
import type { Logger } from 'coc.nvim'

export async function doFormat(
  code: string,
  opts: {
    cwd?: string
    logger?: Logger
  } = {},
) {
  const args: string[] = []
  const { cwd } = opts

  if (cwd) {
    await new Promise((res) => {
      const styluaToml = resolve(cwd, 'stylua.toml')
      access(styluaToml, (err) => {
        if (err === null)
          args.push('-f', styluaToml)

        res(void 0)
      })
    })
  }
  opts.logger?.info(JSON.stringify(args))

  if (args.length === 0)
    return void 0

  args.push('-')

  return new Promise<string>((res, reject) => {
    let result: string = ''

    const child = spawn('stylua', args, {
      cwd,
    })

    child.stdout.on('data', (data) => {
      result += data.toString()
    })

    child.stderr.on('data', (data) => {
      reject(data)
    })

    child.on('error', () => {
      reject(Error('child on error'))
    })

    child.stdout.on('close', () => {
      res(result)
    })

    child.stdin.write(code)

    child.stdin.end()
  })
}
