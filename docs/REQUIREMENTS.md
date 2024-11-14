## Functional requirements

1. smart contract implements a square plane with a side length equal to N (size), where the value of N is given during the initialization of the smart contract, the value of N is impossible to change once the smart contract is implemented,

2. according to the division, the NxN plane consists of smaller and already indivisible elements (land), which form a set M, the number of possible elements in the set M is NxN, each element of the set M has its coordinates (x,y),

3. in the set M of elements, there are elements that are different from the others, these elements belong to one of the 3 sets A (PrizePool.GOLD), B (PrizePool.SILVER) or C (PrizePool.BRONZE), these sets differ in the number of elements, the sum of elements in sets A, B and C is less than the total number of elements of set M,

4. the number of elements in sets A (PrizePool.GOLD), B (PrizePool.SILVER) and C (PrizePool.BRONZE) is given during the initialization of the smart contract, respectively, the values are: (numOfGoldRewards, numOfSilverRewards, numOfBronzeRewards) the elements of these sets, together with the coordinates on the plane, are registered in the smart contract after its implementation by the smart contract owner, it is important that a single element belongs only to one of the three sets A, B or C,

5. it is not possible to re-register elements from sets A (PrizePool.GOLD), B (PrizePool.SILVER) and C (PrizePool.BRONZE), this is a one-time operation, necessary to be carried out by the smart contract owner, if the registration of elements from sets A, B and C has not been carried out, players do not have the possibility to select elements from set M,

6. the coordinates of the elements from sets A (PrizePool.GOLD), B (PrizePool.SILVER) and C (PrizePool.BRONZE) are fed to the smart contract registration function in such a way that it is not possible to know them by reading the data in the smart contract, these coordinates go to the smart contract as the result of a hash function along with a random nonce element,

7. sets A (PrizePool.GOLD), B (PrizePool.SILVER) and C (PrizePool.BRONZE), and their elements are distinguishable, the player selecting an element from set M, gets appropriate feedback whether the selected element belongs to set A, B or C, or is outside them and belongs only to set M, this is implemented based on the mechanism of events, the event also has information about the coordinates of the discovered element,

8. Each time the player selects an element from M set, when he finds an element from set A (PrizePool.GOLD), B (PrizePool.SILVER) or C (PrizePool.BRONZE), he gets a confirmation message, if he finds an element from outside these sets he is also informed about it, a relevant note is also placed in the smart contract, so that it is possible for a given player to read how many elements and from which set he found an element,

9. each time a player selects an element from the set M, he pays a fee O (fee) expressed in ETH, the amount of this fee is given during the contract initialization and cannot be changed after the smart contract implementation,

10. the smart contract stores information about which player, identified by the address of the wallet, has selected how many elements from each of the sets A (PrizePool.GOLD), B (PrizePool.SILVER) or C (PrizePool.BRONZE), a player can hit several elements from the set M, however, at one time a player can provide to the smart contract the coordinates of a maximum of P (maxProvidedLand) elements, the number P is given during the initialization of the smart contract and is not changeable after implementation,

11. each element of the set M, can be selected only once, it is not possible for a player to hit an element of the set M that has already been hit by another player before, if a player provides the coordinates of an element that has already been hit before, the smart contract informs him accordingly, it also does not collect a fee O expressed in ETH,

12. the fees collected from players for picking elements from set M are stored on the contract and are divided into three groups - A (PrizePool.GOLD), B (PrizePool.SILVER) or C (PrizePool.BRONZE),

13. the prizes for players who hit the elements in group A (PrizePool.GOLD), are possible for players to choose by themselves after the minimum number of all elements, defined as T (minDiscElemNumb), is discovered,

14. prizes for players who hit elements from group B (PrizePool.SILVER), are self-selectable by players after the minimum number of all elements, defined as T (minDiscElemNumb), is discovered,

15. the prizes for the player who hit the elements of group C (PrizePool.BRONZE), are possible to self-select by the players after the minimum number of all elements, determined as T (minDiscElemNumb), is discovered,

16. the reward for the player who hits an element from set A (PrizePool.GOLD), B (PrizePool.SILVER) or C (PrizePool.BRONZE) is fixed for each hit element from these sets, are (singleGoldReward, singleSilverReward, singleBronzeReward, respectively) these values are given during the initialization of the smart contract and cannot be changed after implementation,

17. if the number T (minDiscElemNumb) is not reached, it means that too few elements from the set M have been selected by the players, in such a situation after the block number E (blockNumber) given during the initialization of the contract and not changeable after its implementation, is exceeded, the owner of the contract can select all charges to his address,

18. smart contract also implements a simple referrer link mechanism, this mechanism allows you to provide an optional referrer argument to the function that players use to transfer their chosen items (lands) to the smart contract,

19. The referrer link mechanism, each time calculates a point for the address given as referrer when the element (land) given by the player belongs to one of the sets: A (PrizePool.GOLD), B (PrizePool.SILVER) or C (PrizePool.BRONZE).