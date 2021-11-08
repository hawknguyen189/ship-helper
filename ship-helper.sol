pragma solidity 0.8.7;

// SPDX-License-Identifier: MIT

// Part: asteroid_pool

interface asteroid_pool {
    function claimRewardOf(uint) external;
    function getRewardOf(uint) external view returns (uint);
}

// Part: spaceship

interface spaceship {
    function approve(address, uint256) external;
    function getApproved(uint256) external view returns (address);
}



contract ship_helper {

    spaceship constant _ship = spaceship(0x0eD6B3CD4D009575b63b10F944Cd0e6a196B74ae);
    asteroid_pool constant _asteroid = asteroid_pool(0x227583388594f4b02C8C960735AF1E1D3F4DADa3);

    //need approvals
    function claimReward(uint256[] calldata _ids) external {
        uint claimable_reward;
        for (uint i = 0; i < _ids.length; i++) {
            claimable_reward = _asteroid.getRewardOf(_ids[i]);
            if(claimable_reward>0){
                if (_ship.getApproved(_ids[i]) != address(this)) {
                    _ship.approve(address(this), _ids[i]);
                }
                _asteroid.claimRewardOf(_ids[i]);
            }
            
        }
    }

}
