/* Hi everyone, I'm Jessica Marshall, and I work as a software engineer at ConsenSys. Today I'm going
to give you a 15 minute crash course in Ethereum and teach you how to write your own
smart contracts.

The Rules:
1. Jason will facilitate questions.
2. Speak loudly into the microphone - it's hard to hear you all the way from Brooklyn.
3. If you have more in-depth technical questions that won't fit in our timeslot, talk to Jason after
the Meetup or email me at jessica.marshall@consensys.net

-------------------------------------------------------------------------------------------------

Before we get started, let's talk a little bit about Ethereum.
(Full disclosure: some of this is shamelessly lifted from the Ethereum whitepaper)

Ethereum is a transaction-based state machine.
Each state is made up of "accounts."
It might be helpful to imagine Ethereum as a large bank defined by all the accounts it contains
and the interactions between those accounts. This is simplified, but you have to start somewhere.

Each account has an ether balance and maybe some contract code. More about that in a second.

An Ethereum account is defined by a 20 byte-long hexadecimal number called an "address."
    e.g. 0xca35b7d915458ef540ade6068dfe2f44e8fa733c

This is kind of like your bank account number.

Now, an account can fall into one of two categories:
    1. externally owned account (controlled by a person via private keys, no code)
    2. contract account (controlled via its contract code)

If you have the private keys of an EOA, you can interact with other accounts by creating
 and signing a transaction. You can't just send ANY transaction, though.

    simple e.g. I own account A and want to send 1 ether to my sister, who owns account B.

    complicated e.g. I own account A and want to register my identity on uPort. I call the
                     createIdentity function in uPort's IdentityManager contract.

In the first example, the amount of ether in my account goes down, and the ether in my sister's
account goes up.

In the second example, my transaction pokes the uPort contract (provided I did it right),
allowing it to read and write to internal storage and send other messages or create contracts.

To send a transaction to either type of account, I need to know its address. Otherwise I might
accidentally lose some of my hard-earned ether somewhere out there in the ether. LOLXD

Speaking of ether, where does ether play into this?
Ether is the main internal crypto-fuel of Ethereum, and it's used to pay transaction fees to
incentivize the miners who run Ethereum nodes on tons of computers all around the world to
keep paying for the electricty to run those nodes.

Great, so to recap:
Ethereum is made up of accounts that send magical programmable Internet money and poke each
other with transactions that might cause more transmission of magical programmable Internet
money and more pokage.

Oh - one last thing. Once a smart contract is deployed to the blockchain, it can't be changed.
Also, it will always do what its programmed to do.

Protip: MAKE SURE YOU KNOW WHAT YOUR CONTRACT IS PROGRAMMED TO DO and think about how a
        malicious actor might try to exploit it.

Disclaimer: "don't roll your own smart contracts" if you're not a professional or if the
                contract will hold a substantial amount of ether. CODE AUDITS ARE A MUST!
-------------------------------------------------------------------------------------------------

So enough theory, let's write a contract.

The Plan: program my own cryptocurrency (JessToken) using a smart contract.
- the account that deploys the contract will get 1000 jessTokens
- you should be able to transfer jessTokens to other accounts if you have it

BTW, this is Remix, an Ethereum integrated development environment that makes it easy to write,
test, debug, and interact with smart contracts.

*/

pragma solidity ^0.4.8;                  //specify compiler version
//this is a comment!

contract JessToken {                     //this is a smart contract!

    address owner;                       //which account gets the 1000 jessTokens to begin with
    mapping (address => uint) public balances;  //keep track of the number of jessTokens in each account
                                                //public keyword allows anyone to call balances
                                                //(reads an address's balance from blockchain without changing its state)
                                                //calls are different from transactions in that they don't cost ether

    function JessToken() public {
        owner = msg.sender;              //msg.sender is the address of the account that called the function
                                         //here, msg.sender is the account that deployed the contract
        balances[owner] = 1000;          //mint the owner 1000 jessTokens and put it in the mapping
    }

    function transfer(uint amount, address recipient) public {      //move jessTokens between accounts
        require(balances[msg.sender] >= amount);
        require(balances[msg.sender] - amount <= balances[msg.sender]);
        require(balances[recipient] + amount >= balances[recipient]);
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        //hmm, how might evil attacker Jennifer try to exploit this function?
    }
}
