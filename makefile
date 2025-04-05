-include .env

deploy-sepolia:; forge script script/DeployOurToken.s.sol --rpc-url $(SEPOLIA_RPC_URL) --account sepoliaMine --broadcast --verify --etherscan-api-key $($(ETHERSCAN_API_KEY)) ETHERSCAN_API_KEY=UJKIR1R261Y694RPH237RPXJXHSW5713DH -vvvv