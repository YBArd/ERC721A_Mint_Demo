const { expect } = require('chai');
const { ethers, waffle } = require('hardhat');

describe("COIN", () => {

	let owner, coin, COIN, decimals, supply, addr1, addr2, provider;

	beforeEach(async () => {
		[owner, addr1, addr2] = await ethers.getSigners();
		COIN = await ethers.getContractFactory('COIN');
		decimals = 18;
		coin = await COIN.connect(addr1).deploy();
		provider = waffle.provider;
	});

	describe('Deployment', () => {
		
		it("Should set token name to COIN", async () => {
			expect(await coin.name()).to.equal('COIN');
		});

		it("Should set token symbol to COIN", async () => {
			expect(await coin.symbol()).to.equal('COIN');
		});

		it("Should set number of decimals in currency to 18", async () => {
			expect((await coin.decimals()).toString()).to.equal('18');
		});
		it("Should mint 10000 COIN to contract deployer", async () => {
			expect(await coin.balanceOf(addr1.address)).to.equal('10000');
		});
	});

	describe('pause', () => {
		it("Should disable/re-enable transfers when calling pause()/unpause()", async () => {
			coin.pause();
			await expect(coin.transfer(addr2.address, 100)).to.be.revertedWith('Pausable: paused');
			coin.unpause();
			await coin.transfer(addr2.address, 100);
			expect(await coin.balanceOf(addr2.address)).to.equal('100');
		});
	});
});