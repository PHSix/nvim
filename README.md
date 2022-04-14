
<h3 align="center">Neovim Dotfile</h3>
<p align="center">
<svg height=200 xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 54 65" fill="#fff" fill-rule="evenodd" stroke="#000" stroke-linecap="round" stroke-linejoin="round"><use xlink:href="#D" x=".5" y=".5"/><defs><linearGradient x1="50.00%" y1="0.00%" x2="50.00%" y2="100.00%" id="A"><stop stop-color="#16b0ed" stop-opacity=".8" offset="0%"/><stop stop-color="#0f59b2" stop-opacity=".837" offset="100%"/></linearGradient><linearGradient x1="50.00%" y1="0.00%" x2="50.00%" y2="100.00%" id="B"><stop stop-color="#7db643" offset="0%"/><stop stop-color="#367533" offset="100%"/></linearGradient><linearGradient x1="50.00%" y1="-0.00%" x2="50.00%" y2="100.01%" id="C"><stop stop-color="#88c649" stop-opacity=".8" offset="0%"/><stop stop-color="#439240" stop-opacity=".84" offset="100%"/></linearGradient></defs><symbol id="D" overflow="visible"><g stroke="none"><path d="M0 13.761L13.63 0v63.983L0 50.381z" fill="url(#A)"/><path d="M52.664 13.894L38.848.008l.281 63.976 13.63-13.602z" fill="url(#B)"/><path d="M13.621.011l35.435 54.07-9.916 9.915L3.686 10.046z" fill="url(#C)"/><path d="M13.633 25.092l-.019 2.13L2.676 11.069l1.013-1.032z" fill="#000" fill-opacity=".13"/></g></symbol></svg>
</p>

# repository folder instruction

```bash
.
├── after          # after directory
├── colors         # my colorscheme
├── init.lua       # dotfile entry
├── lua            # config lua code
├── README.md      # readme doc
├── remote-plugins # personal remote plugin
├── startuptime    # startuptime log record
├── static         # static files
├── test           # test files
└── TODO.md        # the roadmap in future
```

# plugins instruction
- plugins manager: [packer.nvim]()
- lsp: [nvim-lspconfig]()
- completion engine: [nvim-cmp]()
- colorscheme: [coolors]()
- fuzzy finder: [telescope.nvim]()
- other...
