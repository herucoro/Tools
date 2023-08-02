#!/bin/bash

npm i webpack webpack-cli webpack-dev-server html-webpack-plugin --save-dev

npm i react react-dom

npm i typescript ts-loader @types/react @types/react-dom --save-dev

mkdir public && mkdir src

echo "{
  \"compilerOptions\": {
    \"target\": \"es2015\",
    \"module\": \"esnext\",
    \"outDir\": \"./dist/\",
    \"esModuleInterop\": true,
    \"moduleResolution\": \"node\",
    \"jsx\": \"react\",
    \"allowJs\": true,
    \"strict\": true,
    \"skipLibCheck\": true,
    \"forceConsistentCasingInFileNames\": true,
  },
}" > tsconfig.json

echo "import React from 'react';
import { createRoot } from 'react-dom/client';
 import App from './src/App';

 const root = createRoot(document.getElementById('root') as HTMLElement);
 root.render(
   <React.StrictMode>
     <App />
   </React.StrictMode>
 );" > index.tsx

echo "<html lang='ja'>
  <head>
    <meta charset='UTF-8'>
    <title>React app</title>
  </head>
  <body>
    <div id='root'></div>
  </body>
</html>" > ./public/index.html

echo "import React from 'react';
import type { FC } from 'react';

  const App: FC = () => {
  return <h1>Hello, world!</h1>;
};

export default App;" > ./src/App.tsx

echo "const HtmlWebpackPlugin = require('html-webpack-plugin');
const path = require('path');

module.exports = {
  entry: './index.tsx',
  mode: 'development',
  output: {
    path: path.resolve(__dirname, './dist'),
    filename: 'bundle.js',
  },
  target: 'web',
  devServer: {
    port: '3000',
    static: {
      directory: path.join(__dirname, 'public'),
    },
    open: true,
    hot: true,
    liveReload: true,
  },
  resolve: {
    extensions: ['.tsx', '.ts', '.js'],
  },
  module: {
    rules: [
      {
        test: /\.(js|ts|tsx)$/,
        exclude: /node_modules/,
        use: 'ts-loader',
      },
    ],
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: path.join(__dirname, 'public', 'index.html'),
    }),
  ],
};" > webpack.config.js

echo "\"scripts\": {
  \"start\": \"webpack-dev-server .\",
  \"build\": \"webpack .\"
}," >> package.json
