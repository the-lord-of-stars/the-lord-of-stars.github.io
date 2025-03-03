---
title: AIM Lab CW1 Prediction

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
   - Sample the search space through neighbourhood operators.  No optimality guarantees.

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

## Week 5

### Lab Code

## Week 6