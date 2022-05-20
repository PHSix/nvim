const { translate } = require("bing-translate-api");
const minimist = require("minimist");

var argv = require("minimist")(process.argv.slice(2));

translate(argv["_"][0], null, argv["to"], true).then((res) => {
  console.log(res["translation"]);
});
