---
title: AIM Lab CW1 Prediction

date: 2025-03-03

tags:
- academic
- review

description: |
    This is the prediction for the AIM Lab Quiz. I will gather all the key information in the previous lab quiz and provide a prediction for the exam.
---

## Week 1

### Lab Code
The RandomBitFlipHeuristic:
```java
public void applyHeuristic(SAT problem) {
    // Select a random bit to flip
   int randomIndex = random.nextInt(problem.getNumberOfVariables());
   problem.bitFlip(randomIndex, CURRENT_SOLUTION_INDEX);
}
```

### Lab Quiz
In week1, the lab quiz was just all about the introduction of the api and the basis for the question, the Max-SAT problem concept.

1. **Max-SAT** is a problem in computer science that involves finding a solution to a boolean satisfiability problem (SAT) by finding a subset of the variables that satisfy all the clauses in the SAT problem. The goal is to find a solution that maximizes the number of satisfied clauses. The Max-SAT problem is NP-complete, meaning that it is not possible to solve in polynomial time for all possible inputs. However, there are many heuristics that can be used to solve the problem efficiently in practice.

   ex. (A ∨ ¬B) ∧ (B ∨ C) ∧ (¬A ∨ ¬C)

2. In the lab, a very important concept of the **Random** was given. That is the value of the random function is not actually random, but is determined by a seed value. This seed value is used to generate a sequence of pseudo-random numbers that can be used for various purposes, such as generating random numbers, selecting random elements from a set, and shuffling a list. The seed value can be set to a fixed value to produce a deterministic sequence of pseudo-random numbers, or it can be set to a random value to produce a different sequence each time the program is run. Therefore, if the seed value is not changed in each trial, it will always give us the same solution. 

### Question Quiz

1. **Concept**:
   
   - **Open** decision support system (depend on the environment), **Close** decision support system (independent),
   - **effective** (can find the best solution), efficient (fast).
   
2. **Concept**:
   
   - **Stochastic** searching  method (vary from time to time), **deterministic** searching method (always the same result),
   - **perturbative** searching method (start with a complete solution and gradually change it), **constructive** searching method (start with an partial solution and gradually build it).
   
3. **Concept**: 

   **Exact methods**
   - Dynamic programming, Branch and Bound, Constraint Satisfaction 
   - Systematically traverse the search space.
   - Has optimality guarantees

   **Inexact methods**
   - Heuristics/Metaheuristics/Hyper-heuristics
   - Sample the search space through neighbourhood operators. 
   - No optimality guarantees.

## Week 2

### Lab Code
Steepest Descent Hill Climbing:
```java
public void applyHeuristic(SAT problem) {
    double bestEval = problem.getObjectiveFunctionValue(CURRENT_SOLUTION_INDEX);
    int bestIndex = 0;
    boolean improved = false;

    for (int j = 0; j < problem.getNumberOfVariables(); j++) {
        problem.bitFlip(j, CURRENT_SOLUTION_INDEX);
        double eval = problem.getObjectiveFunctionValue(CURRENT_SOLUTION_INDEX);

        if (eval < bestEval) {
            bestIndex = j;
            bestEval = eval;
            improved = true;
        }
        problem.bitFlip(j, CURRENT_SOLUTION_INDEX);
    }

    if (improved) {
        problem.bitFlip(bestIndex, CURRENT_SOLUTION_INDEX);
    }
}
```

Davis's Bit Hill Climbing:
```java
public void applyHeuristic(SAT problem) {
    double bestEval = problem.getObjectiveFunctionValue(CURRENT_SOLUTION_INDEX);
    int[] perm = new int[problem.getNumberOfVariables()];

    for (int i = 0; i < problem.getNumberOfVariables(); i++) {
        perm[i] = i;
    }
    perm = ArrayMethods.shuffle(perm, random);

    for (int j = 0; j < problem.getNumberOfVariables(); j++) {
        problem.bitFlip(perm[j], CURRENT_SOLUTION_INDEX);
        double tempEval = problem.getObjectiveFunctionValue(CURRENT_SOLUTION_INDEX);

        if (tempEval <= bestEval) {
            bestEval = tempEval;
        } else {
            problem.bitFlip( perm[j], CURRENT_SOLUTION_INDEX);
        }
    }
}
```

### Lab Quiz
In week2, the lab is focusing on Steepest Descent Hill Climbing and Davis's Bit Hill Climbing.

1. **Steepest Descent Hill Climbing** is a local search algorithm that starts with a random solution and only change the most significant bit that decreases the objective function value. It is a simple and effective algorithm that can find a good solution in a short time. However, it may not find the global optimum.
2. **David's Bit Hill Climbing** is a local search algorithm that will initially create a random permutation of the changing indexes list, and improve the solution gradually.

If we change the heuristic to **better or equal than** the current solution:

Correct answers would identify that DBHC performs better accepting non-worsening moves; however, SDHC could perform different based on the acceptance criteria.

For DBHC this includes not getting stuck on shoulder regions, whereas for SDHC this is down to two factors. In one case, we may be able to move over the shoulder regions leading to better performance, but in the other case, preferring to change the latter variable assignments may lead to getting stuck in regions of the search space with poor quality solutions as compared to flipping earlier variable assignments.

## Week 3

### Lab Code
Iterated Local Search:
```java
protected void runMainLoop() {
    for (int i = 0; i < iIntensityOfMutation; i++) {
        // apply mutation heuristic
       oMutationHeuristic.applyHeuristic(problem);
    }
    for (int i = 0; i < iDepthOfSearch; i++) {
        oLocalSearchHeuristic.applyHeuristic(problem);
    }
    double backEval = problem.getObjectiveFunctionValue(BACKUP_SOLUTION_INDEX);
    double newEval = problem.getObjectiveFunctionValue(CURRENT_SOLUTION_INDEX);

    if (newEval <= backEval) {
        // accept new solution
       problem.copySolution(CURRENT_SOLUTION_INDEX, BACKUP_SOLUTION_INDEX);
    }else{
        // reject new solution
       problem.copySolution(BACKUP_SOLUTION_INDEX, CURRENT_SOLUTION_INDEX);
    }
}
```

### Lab Quiz

In week 3, the lab is focusing on iterated local search.

1. Q2: 

   ILS is only applying hill-climbing and hence has no explorative mechanisms when IOM is set to zero.

   "behave" is not like "perform", behave means the outcomes could be the same, perform is more enphasizing the procedure.

2. Q4:

   **tail selection**: you should choose 1 tail when you want to know the direction of the data (> or <)

   and you should choose 2 tail if you want to know if there is a difference between 2 set of data.

   **Test type:**

   | Test Name                 | data               | scene                     | Critera      |
   | ------------------------- | ------------------ | ------------------------- | ------------ |
   | T test                    | independent/paired | focus on mean difference  | mean         |
   | Wilcoxon SIgned Rank Test | paired             | not Gaussian distribution | middle value |
   | Mann-Whitney U test       | independent        | not Gaussian distribution | middle value |
   | Sign Test                 | paired             | focus on direction        | middle value |

   **P value:** when p value is big (usually >= 0.05) then we can not disagree the h0: the 2 data sets are identical. only when p value is < than 0.05 then we can use the relevant critera to decide which method is better/ worse. 

3. Q5: 
   The behaviour of ILS with different components can be totally different and hence may require entirely different configurations for IOM and DOS

4. Q7:

   The first is that the combination of SDHC with the 1-bit flip neighbourhood is not ideal as SDHC flipping a single bit that leads to the most improvement can easily undo changes by the mutation operator.

   The second point makes a comparison of SDHC and DBHC in terms of their efficiency and effectiveness (see ILS design guidelines from lecture 3). Both hill-climbing heuristics make the same number of function evaluations per pass (take the same computational budget) however DBHC is able in theory to modify [0,n) bits whereas SDHC can only modify [0,1] bits; hence SDHC is less efficient than DBHC.

## Week 4

### Lab Code
Simulated Annealing:
```java
protected void runMainLoop() {
    double temperature = oCoolingSchedule.getCurrentTemperature();
    double eval = problem.getObjectiveFunctionValue(CURRENT_SOLUTION_INDEX);

    // Select a random bit to flip
   int randomIndex = random.nextInt(problem.getNumberOfVariables());
   problem.bitFlip(randomIndex, CURRENT_SOLUTION_INDEX);
   double newEval = problem.getObjectiveFunctionValue(CURRENT_SOLUTION_INDEX);
   double delta = newEval - eval;
   double probability = Math.exp(-delta/temperature);

   // If the new solution is better or the probability is higher, accept it
   if (delta < 0 || random.nextDouble() < probability) {
       problem.bitFlip(randomIndex, BACKUP_SOLUTION_INDEX);
   }else {
       problem.bitFlip(randomIndex, CURRENT_SOLUTION_INDEX);
   }

   // Update the temperature
   oCoolingSchedule.advanceTemperature();
}
```

Geometric Cooling Schedule:
```java
public void advanceTemperature() {
    dCurrentTemperature *= this.dAlpha;
}
```

LundyAndMees Cooling Schedule:
```java
public void advanceTemperature() {
    dCurrentTemperature =  dCurrentTemperature / ( 1 + dBeta * dCurrentTemperature );
}
```

### Lab Quiz

This week lab is relative simple, it is only focusing on the Simulated Annealing: 

- The algorithm is allowed to occasionally accept a poor solution (that is, a solution worse than the current one), thus jumping out of the local optimal.
- By decreasing the temperature parameter (T), the probability of accepting the poor solution is reduced, so that the solution gradually converges to the global optimal.

The key to solve the quiz is that the alpha for geometric cooling schema should be very close to 1 (ex. 0.99998). If the temperature get cooled so fast then the algorithm will just become the IE algorithm. Similarly, the beta for LundyAndMees Cooling Schema should be very small (ex. 0.00001).



## Week 5

### Lab Code
Memetic Algorithm:
```java
public void runMainLoop() {
    for(int iIterationCount = 0; iIterationCount < POPULATION_SIZE; iIterationCount += 2) {
        int iParent1, iParent2;
        iParent1 = p1Selection.parentSelection();
        iParent2 = p2Selection.parentSelection();
        if(iParent1 == iParent2) {
            iParent2 = (iParent1 + 1) % POPULATION_SIZE;
        }
        int iChild1 = POPULATION_SIZE + iIterationCount;
        int iChild2 = POPULATION_SIZE + iIterationCount +1;
        crossover.applyHeuristic(iParent1, iParent2, iChild1, iChild2);
        mutation.applyHeuristic(iChild1);
        localSearch.applyHeuristic(iChild1);
        mutation.applyHeuristic(iChild2);
        localSearch.applyHeuristic(iChild2);
    }
    // not forgetting to do replacement of the population AFTER all offspring are produced
   replacement.doReplacement(problem, POPULATION_SIZE);
}
```

Crossover (UniformXO):
```java
public void applyHeuristic(int parent1Index, int parent2Index,
			int child1Index, int child2Index) {
    problem.copySolution(parent1Index, child1Index);
    problem.copySolution(parent2Index, child2Index);

    for(int i = 0; i < problem.getNumberOfVariables(); i++) {
        if(random.nextDouble() < 0.5) {
            problem.exchangeBits(child1Index, child2Index, i);
        }
    }
}
```

Selection (Tournament Selection):
```java
public int parentSelection() {
	int bestIndex = -1;
	double bestFitness = Double.MAX_VALUE;

	//create list of random indices
	int[] indices = ArrayMethods.shuffle(aiParentIndices, oRandom);

	// select from the first tournamentSize elements
	for(int i = 0; i < iTournamentSize; i++) {
		int sol = indices[i];
		double fitness = oProblem.getObjectiveFunctionValue(sol);

		// don't need to be concerned about selecting randomly from multiple best
		// solutions as the tournamentSize parents were already randomised.
		if(fitness < bestFitness) {
			bestFitness = fitness;
			bestIndex = sol;
		}
	}

	return bestIndex;
}
```

Replacement (TransGenerational Replacement):
```java
protected int[] getNextGeneration(SAT oProblem, int iPopulationSize) {

		// total population size is size of parent population plus size of offspring population
		int iTotalPopulationSize = iPopulationSize << 1;

		// offspring indices are from 'populationSize' inclusive to 'populationSize * 2' exclusive.
		int[] aiOffspringMemoryIndices = IntStream.range(iPopulationSize, iTotalPopulationSize).toArray();

		// see if the best solution is in the current population or offspring population
		double dBestSolutionCost = Double.MAX_VALUE;
		double dWorstOffspringCost = -Double.MAX_VALUE;
		int bestIndex = -1;
		int worstOffspringIndex = -1;

		// evaluate the objective function value (cost) of each solution from both parent and offspring populations
		for(int iMemoryIndex = 0; iMemoryIndex < iTotalPopulationSize; iMemoryIndex++) {

			double dSolutionCost = oProblem.getObjectiveFunctionValue(iMemoryIndex);

			// update index of the best solution, favouring offspring solutions
			if( dSolutionCost <= dBestSolutionCost ) {
				dBestSolutionCost = dSolutionCost;
				bestIndex = iMemoryIndex;
			}

			// keep track of the worst solution in the offspring population
			if( iMemoryIndex >= iPopulationSize && dSolutionCost > dWorstOffspringCost) {

				worstOffspringIndex = iMemoryIndex;
				dWorstOffspringCost = dSolutionCost;
			}
		}

		// if best solution is in parent population, replace worst in offspring with best from parents
		if(bestIndex < iPopulationSize) {

			aiOffspringMemoryIndices[worstOffspringIndex - iPopulationSize] = bestIndex;
		}

		// return array of memory locations for replacement
		return aiOffspringMemoryIndices;
	}
```

### Lab Quiz

This week lab is focusing on the genetic algorithm:

**Population Initialization**

- Generate a set of random individuals (solutions) as the initial population.

**Fitness Evaluation**

- Compute the fitness of each individual to measure the quality of its solution.

**Selection**

- Select individuals with higher fitness to enter the next generation (simulating natural selection).

**Crossover**

- Choose two parent individuals to exchange genetic material and generate new offspring (simulating biological reproduction).

**Mutation**

- Introduce small random changes in individuals with a low probability (simulating genetic mutation).

**New Generation Formation**

- Replace the old population with the new one and repeat the iteration until the termination condition is met (e.g., reaching the maximum number of generations or convergence).

1. Q3:

   Memetic algorithm: add local search part (hill climbing) to optimize the children.

   ex:

​	*A [named] statistical test was conducted to test whether the median performance of the GA and MA perform significantly different from each other. The experiments were run for a total of 31 trials with the GA using 1000 generations and the MA using 250 generations respectively resulting in a total runtime of 10 seconds each. The result of performing the [named] test shows that the MA performs significantly better than the GA with a p-value = 0.00018 and the GA and MA obtaining median results of 81 and 24 respectively”.*



## Week 6

### Lab Code

Simple Inheritance:

```java
public void performMemeticInheritance(int parent1Index, int parent2Index, int child1Index, int child2Index) {
	double v1 = problem.getObjectiveFunctionValue(parent1Index);
	double v2 = problem.getObjectiveFunctionValue(parent2Index);
	int number = problem.getNumberOfMemes();
  
  // if same then choose parent randomly
	if (v1 == v2) {
		int inheritIndex = rng.nextDouble() < 0.5 ? parent1Index : parent2Index;
		for (int i = 0; i < number; i++) {
			problem.getMeme(child1Index, i).setMemeOption(problem.getMeme(inheritIndex, i).getMemeOption());
			problem.getMeme(child2Index, i).setMemeOption(problem.getMeme(inheritIndex, i).getMemeOption());
		}
  // if < choose parent 1  
	} else if (v1 < v2) {
		for (int i = 0; i < number; i++) {
			problem.getMeme(child1Index, i).setMemeOption(problem.getMeme(parent1Index, i).getMemeOption());
			problem.getMeme(child2Index, i).setMemeOption(problem.getMeme(parent1Index, i).getMemeOption());
		}
  // if < choose parent 2  
	} else {
		for (int i = 0; i < number; i++) {
			problem.getMeme(child1Index, i).setMemeOption(problem.getMeme(parent2Index, i).getMemeOption());
			problem.getMeme(child2Index, i).setMemeOption(problem.getMeme(parent2Index, i).getMemeOption());
		}
	}
}
```

MutiMeme:

```java
public void runMainLoop() {
	for(int i = 0; i < POPULATION_SIZE; i+=2) {
		// select two parents. we don't care if they are the same this week
		int p1 = p1selection.parentSelection();
		int p2 = p2selection.parentSelection();

		// calculate child indices
		int c1 = i + POPULATION_SIZE;
		int c2 = c1 + 1;
			
		// apply crossover
		crossover.applyHeuristic(p1, p2, c1, c2);

		// inherit memeplex using simple inheritance method
		inheritance.performMemeticInheritance(p1, p2, c1, c2);

    // mutation of memeplex (innovation)
		performMutationOfMemeplex(c1);
		performMutationOfMemeplex(c2);
    
		// mutation (change iom)
		applyMutationForChildDependentOnMeme(c1, 0);
		applyMutationForChildDependentOnMeme(c2, 0);

		// local search
		applyLocalSearchForChildDependentOnMeme(c1, 1, 2);
		applyLocalSearchForChildDependentOnMeme(c2, 1, 2);
	}
		
	// perform replacement
	replacement.doReplacement(problem, POPULATION_SIZE);
}
	
	/**
	 * Applies mutation to the child dependent on its current meme option for mutation.
	 * Mapping of meme option to IOM: IntensityOfMutation <- memeOption;
	 */
public void applyMutationForChildDependentOnMeme(int childIndex, int memeIndex) {
	int iom = problem.getMeme(childIndex, memeIndex).getMemeOption();
	mutation.setMutationRate(iom);
	mutation.applyHeuristic(childIndex);
}
	
	/**
	 * Applies the local search operator to the child as specified by its current meme option.
	 */
public void applyLocalSearchForChildDependentOnMeme(int childIndex, int operatorMemeIndex, int depthOfSearchMemeIndex) {
	int option = problem.getMeme(childIndex, operatorMemeIndex).getMemeOption();
	int depth = problem.getMeme(childIndex, depthOfSearchMemeIndex).getMemeOption();
	for (int i = 0; i < depth; i++) {
		lss[option].applyHeuristic(childIndex);
	}
}

	/**
	 * Applies mutation to each meme within the memeplex of the specified solution with probability
	 * dependent on the innovation rate.
	 */
public void performMutationOfMemeplex(int solutionIndex) {
	for (int i = 0; i < problem.getNumberOfMemes(); i++){
		Meme meme = problem.getMeme(solutionIndex, i);
		int initialOption = meme.getMemeOption();
		if (rng.nextDouble() < innovationRate) {
			int newOption = rng.nextInt(meme.getTotalOptions());
			while (newOption == initialOption){
				newOption = rng.nextInt(meme.getTotalOptions());
			}
			meme.setMemeOption(newOption);
		}
	}
}
```

### Lab Quiz

This week lab is focusing on the multi-meme algorithm.

**Initialization**

- Generate an initial population where each individual is assigned a **memeplex**.

**Iterative Evolution (for MaxGenerations)**

- **Selection & Crossover**: Select parents (e.g., tournament selection) and perform crossover while **inheriting memes**.
- **Innovation-Based Meme Mutation**: With probability dependent on the **innovation rate**, modify memes in offspring.
- **Genetic Mutation**: Apply standard mutation to offspring, influenced by the inherited memeplex.
- **Local Search**: Offspring undergo local search using an operator dictated by their memeplex.
- **Population Replacement**: Update the population while preserving diversity.

**Termination**

- Stop when a convergence criterion is met (e.g., best fitness stagnation, max iterations).





