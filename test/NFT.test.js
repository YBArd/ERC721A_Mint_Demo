const { expect } = require('chai');
const { ethers, waffle } = require('hardhat');

describe('NFT', () => {
	let coin, COIN, NFT, nft, coinAddress, supply, addr1, addr2, provider;

	beforeEach(async () => {
		[owner, addr1, addr2] = await ethers.getSigners();
		NFT = await ethers.getContractFactory('NFT');
		COIN = await ethers.getContractFactory('COIN');
		coin = await COIN.connect(addr1).deploy();
		nft = await NFT.connect(owner).deploy(coin.address);
		provider = waffle.provider;
		await coin.approve(nft.address, 1000);
	});

	describe('safemint', async () => {
		it("Should mint 1 NFT to addr1 and deduct 1000 COIN", async () => {
			expect(await coin.balanceOf(addr1.address)).to.equal(10000);
			await nft.connect(addr1).safeMint();
			expect(await nft.balanceOf(addr1.address)).to.equal(1);
			expect(await coin.balanceOf(addr1.address)).to.equal(9000);
		});
	});

	describe('withdrawal', async () => {
		it("Contract owner should be able to withdraw COIN balance from minting revenue", async () => {
			await nft.connect(addr1).safeMint();
			await nft.connect(owner).rugTheFunds();
			expect(await coin.balanceOf(owner.address)).to.equal(1000); 
		});
	});
});