const JessToken = artifacts.require('./JessToken.sol')

module.exports = async function (deployer) {
  await deployer.deploy(JessToken)
}
