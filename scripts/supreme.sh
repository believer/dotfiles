#!/bin/bash

REDBG="\033[101m"
GREENTEXT="\033[92m"
GRAYTEXT="\033[90m"
DEFAULT="\033[0m"

PROJECTNAME=$1

if [ -z "$1" ]
  then
    echo -e "
    You are missing the first parameter 

    ${GRAYTEXT}Example: ${DEFAULT}supremereason ${GREENTEXT}reponame"

    exit 1
fi

echo -e "
${REDBG}Supreme${DEFAULT} is bootstrapping your ReasonML code.
"

# Create project directory with base setup
bsb -init $PROJECTNAME -theme react-hooks &>/dev/null

cd $1

# Overwrite base package.json
cat >package.json <<EOL
{
  "name": "your-react-app",
  "version": "0.1.0",
  "scripts": {
    "build": "bsb -make-world",
    "start": "BS_WATCH_CLEAR=true bsb -make-world -w",
    "clean": "bsb -clean-world",
    "test": "echo \"Error: no test specified\" && exit 1",
    "webpack": "webpack -w",
    "webpack:production": "NODE_ENV=production webpack",
    "server": "webpack-dev-server"
  },
  "keywords": [
    "BuckleScript"
  ],
  "author": "",
  "license": "MIT",
  "dependencies": {
    "react": "16.8.6",
    "react-dom": "16.8.6",
    "reason-react": "0.7.0"
  },
  "devDependencies": {
    "autoprefixer": "9.6.0",
    "bs-platform": "5.0.4",
    "css-loader": "3.0.0",
    "html-webpack-plugin": "3.2.0",
    "postcss-loader": "3.0.0",
    "style-loader": "0.23.1",
    "tailwindcss": "1.0.4",
    "webpack": "4.34.0",
    "webpack-cli": "3.3.4",
    "webpack-dev-server": "3.7.1"
  }
}
EOL

# Install dependencies
npm install --silent &>/dev/null

echo -e " - Dependencies installed ✅"

npx tailwind init &>/dev/null

cat >postcss.config.js <<EOL
module.exports = {
  plugins: [require("tailwindcss"), require("autoprefixer")]
};
EOL

cat >src/index.css <<EOL
@tailwind base;
@tailwind components;
@tailwind utilities;

html,
body {
  @apply font-normal m-0 p-0;
}
EOL

cat >src/index.js <<EOL
require("./index.css");
require("../lib/js/src/Index.bs");
EOL

# Create public folder and move index
mkdir public
mv src/index.html public/index.html

# Overwrite index
cat >public/index.html <<EOL
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>ReasonReact Examples</title>
</head>
<body>
  <div id="root"></div>
</body>
</html>
EOL

# Overwrite bsconfig
cat >bsconfig.json <<EOL
{
  "name": "react-hooks-template",
  "reason": {
    "react-jsx": 3
  },
  "sources": {
    "dir": "src",
    "subdirs": true
  },
  "package-specs": [
    {
      "module": "commonjs"
    }
  ],
  "suffix": ".bs.js",
  "namespace": true,
  "bs-dependencies": ["reason-react"],
  "refmt": 3
}
EOL

# Overwrite webpack
cat >webpack.config.js <<EOL
const path = require("path");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const outputDir = path.join(__dirname, "build/");

const isProd = process.env.NODE_ENV === "production";

module.exports = {
  mode: isProd ? "production" : "development",
  output: {
    path: outputDir,
    filename: "index.js"
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: "public/index.html"
    })
  ],
  devServer: {
    compress: true,
    contentBase: outputDir,
    port: process.env.PORT || 3000,
    historyApiFallback: true,
    stats: 'minimal'
  },
  module: {
    rules: [
      {
        test: /\.css$/,
        use: [
          "style-loader",
          { loader: "css-loader", options: { importLoaders: 1 } },
          "postcss-loader"
        ]
      }
    ]
  }
};
EOL

# Overwrite index
cat >src/Index.re <<EOL
ReactDOMRe.renderToElementWithId(<App />, "root");
EOL

# Remove components and add base App
rm src/Component1.re
rm src/Component2.re

cat >src/App.re <<EOL
[@react.component]
let make = () => {
  <div className="bg-blue-200 min-h-screen flex items-center justify-center text-4xl">
    {React.string("Welcome to your app")}
  </div>
};
EOL

echo -e " - Bootstrapping done ✅"

echo -e "
Get your app running by opening two terminal tabs and
running the following commands:

  * ${GREENTEXT}npm start${GRAYTEXT} (starts compiler)
  ${DEFAULT}* ${GREENTEXT}npm run server${GRAYTEXT} (start Webpack on port 3000)
"

