const JessToken = artifacts.require('JessToken')
const Promise = require('bluebird')
web3.eth = Promise.promisifyAll(web3.eth)

async function getRandomNumberUnder1000() {
  return Math.floor(Math.random() * (999)) + 1;
}

async function getRandomNumberAbove1000() {
  return Math.floor(Math.random() * (999)) + 1000;
}

contract('JessToken', (accounts) => {
  let jessica
  let jennifer
  let jordan
  let jessToken

  before(async function() {
    // Truffle deploys contracts with accounts[0], therefore jessica is msg.sender and owner
    //jennifer and jordan should start off with 0 JessTokens
    jessica = web3.eth.accounts[0]
    jennifer = web3.eth.accounts[1] // attacker
    jordan = web3.eth.accounts[2]
    jessToken = await JessToken.new({from: jessica})
  })

  it('correctly assigns 1000 JessTokens to jessica', async function() {
    let jessBalance = await jessToken.balances.call(jessica)
    assert.equal(jessBalance, 1000, 'Jessica did not receive 1000 JessTokens')
    })

  it('correctly assigns 0 JessTokens to jennifer', async function() {
      let jenBalance = await jessToken.balances.call(jennifer)
      assert.equal(jenBalance, 0, 'Jennifer was assigned tokens she shouldn\'t have')
      })

  it('correctly assigns 0 JessTokens to jordan', async function() {
      let jordanBalance = await jessToken.balances.call(jordan)
      assert.equal(jordanBalance, 0, 'Jennifer was assigned tokens she shouldn\'t have')
      })

  it('allows jessica to successfully transfer tokens she has', async function() {
    let amount = await getRandomNumberUnder1000()
    let tx = await jessToken.transfer(amount, jordan, {from: jessica})
    let jessBalance = await jessToken.balances.call(jessica)
    let jordanBalance = await jessToken.balances.call(jordan)
    assert.equal(jessBalance, 1000 - amount, 'Jessica did not successfully transfer tokens')
    assert.equal(jordanBalance, amount, 'Jessica did not successfully transfer tokens')
    })

  it('does not allow jessica to transfer more tokens she has', async function() {
    let errorThrown = false
    let amount = await getRandomNumberAbove1000()
    let jessBalanceBefore = await jessToken.balances.call(jessica)
    jessBalanceBefore = jessBalanceBefore.toNumber()
    let jordanBalanceBefore = await jessToken.balances.call(jordan)
    jordanBalanceBefore = jordanBalanceBefore.toNumber()
    try {
      await jessToken.transfer(amount, jordan, {from: jessica})
    } catch (error) {
      errorThrown = true
    }
    assert.equal(errorThrown, true, 'transfer should have thrown')
    let jessBalance = await jessToken.balances.call(jessica)
    let jordanBalance = await jessToken.balances.call(jordan)
    assert.equal(jessBalance, jessBalanceBefore, 'Jessica\'s token balance should not have changed')
    assert.equal(jordanBalance, jordanBalanceBefore, 'Jordan\'s token balance should not have changed')
    })

  it('does not allow jennifer to transfer tokens as she she doesn\'t have any', async function() {
    let errorThrown = false
    let amount = await getRandomNumberAbove1000()
    let jenBalanceBefore = await jessToken.balances.call(jennifer)
    jenBalanceBefore = jenBalanceBefore.toNumber()
    let jordanBalanceBefore = await jessToken.balances.call(jordan)
    jordanBalanceBefore = jordanBalanceBefore.toNumber()
    try {
      await jessToken.transfer(amount, jordan, {from: jennifer})
    } catch (error) {
      errorThrown = true
    }
    assert.equal(errorThrown, true, 'transfer should have thrown')
    let jenBalance = await jessToken.balances.call(jennifer)
    let jordanBalance = await jessToken.balances.call(jordan)
    assert.equal(jenBalance, jenBalanceBefore, 'Jessica\'s token balance should not have changed')
    assert.equal(jordanBalance, jordanBalanceBefore, 'Jordan\'s token balance should not have changed')
    })
})
