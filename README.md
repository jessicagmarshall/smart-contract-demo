# JessToken Smart Contract Demo

This repository contains the Solidity smart contract `JessToken.sol` presented at the DC Ethereum Meetup on November 8th, 2017. It also contains some files that serve as an example of how smart contracts can be compiled, deployed, and tested using the [Truffle framework](http://truffleframework.com/).

Feel free to open a pull request if you find any errors or have any questions!

## Setup

Clone this repository to your machine. If you're new to Github, click the green `Clone or download` button in the upper right hand corner of this repository.

If you don't have node installed, [do that next](https://nodejs.org/en/download/).

For these tests to run correctly, you'll need to have [Truffle v4.0.0](https://github.com/trufflesuite/truffle/releases/tag/v4.0.0) installed. Using other versions of truffle will result in solc warnings & errors. While you're at it, clone the node_modules into the repo as well. If you don't, you'll end up running into strange bluebird errors.

To do all of this, run the following command in terminal (make sure you're in the directory where you want all these files!):

```
$ npm install -g truffle
$ npm install
```

## What are all these files?

I got all of these folders and most of these files by typing the following commands into terminal:

```
$ mkdir <directoryname>
$ cd <directoryname>
$ truffle init
```
You don't need to do this as I already did for this repository, but it's good practice in case you want to write contracts and tests for your own projects.

The [truffle documentation](http://truffleframework.com/docs/) explains most of the resulting folders and files in depth, but here's a TL;DR.

##### contracts/

* folder containing the `.sol` contract files
* don't touch `Migrations.sol` - it was created automatically when I ran `truffle init`
* I created and wrote `JessToken.sol` - it's the contract I want to test

##### migrations/

* folder containing numbered `.js` files that deploy your contracts to Truffle's integrated test blockchain at testing time
* don't touch `1_initial_migration.js` - it was created automatically when I ran `truffle init`
* I created and wrote `2_deploy_jesstoken.js` - in it, I use Truffle's `deployer` object to deploy `JessToken.sol` to the test blockchain

##### test/

* folder containing test `.js` files that tell Truffle how to test your contracts via a modified framework that uses the [Mocha](https://mochajs.org/) testing framework and [Chai](http://chaijs.com/) for assertions
* I created and wrote `exampleTest.js` - in it, I've written some examples that test my contract's functionality

##### build/

* you shouldn't see this folder until you've deployed (migrated) your contracts to the test blockchain
* contains a `contracts/` folder containing `.json` files with the same names as your smart contracts - these are called contract artifacts, and will be used in your test files because JavaScript understands JSON objects better than it understands Solidity

##### truffle.js & truffle-config.js

* this is your main configuration file - don't worry about these for now. I think you can delete `truffle-config.js` if you don't run Windows, but I'm not 100% sure so don't touch it

## Run Tests

Congratulations, you've made it to testing! Make sure you're in the directory that contains `test/` and run the following terminal command:

`$ truffle develop`

In the resulting command line interface, run the following commands:

`truffle(develop)> compile`

The `compile` command compiles your contracts (duh) and alerts you about syntax errors and other warnings that prevent your contracts from compiling. If it's successful, it will create the `build/` folder I told you about.

`truffle(develop)> migrate`

The `migrate` command will run the migration files in the `migrations/` folder in their numbered order. If you've run this command before, I suggest adding a `--reset` to the end of the command to make sure you don't run into weird issues.

`truffle(develop)> test`

This command is fun. It'll run all of the test files in the `test` folder and output lots of nice looking green checkmarks. If any of them come out red, it's probably because you missed a step somewhere.

### Good luck, young grasshopper, and happy smart contracting!
