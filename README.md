## multi-traveling-salesman-problem


This repository contains MATLAB code for solving the Multi-Salesman Problem (MSP) using the Genetic Algorithm (GA). The MSP is an extension of the classic Traveling Salesman Problem (TSP), where multiple salesmen must visit a set of cities, each starting and ending at a designated depot, with the goal of minimizing the total distance traveled.

# Problem Description
# Multi-Salesman Problem (MSP)
In the MSP, the objective is to assign a set of cities to multiple salesmen in such a way that each city is visited exactly once, each salesman starts and ends their route at the depot, and the total distance traveled by all salesmen is minimized. This problem is widely applicable in logistics, route planning, and other fields where efficient distribution of resources is essential.

# Genetic Algorithm (GA)
The Genetic Algorithm is a metaheuristic inspired by the process of natural selection. It uses techniques such as selection, crossover, and mutation to evolve a population of potential solutions over several generations.

# Crossover Techniques:
- Single-Point Crossover: In this method, a single crossover point is selected on the parent chromosomes. The genetic material is then swapped between the parents at this point to create two new offspring. This method is simple but can limit the exploration of the solution space.
- Multi-Point Crossover: In contrast, multi-point crossover involves selecting multiple crossover points. This allows the offspring to inherit a more varied combination of genetic material from both parents, promoting greater diversity in the population and potentially leading to better solutions.
These techniques were used to generate solutions within the Genetic Algorithm, and their effectiveness can vary depending on the specific problem instance and parameters used.

# Solution Visualization
The code generates visualizations to illustrate the solution process:

Convergence Plot: Shows the best cost (total distance) as the algorithm iterates, indicating how the solution improves over time.
Salesmen Routes Plot: Displays the routes taken by each salesman on the 2D plane, with the depot at the center.

![Alt text](images/ga_sa.jpeg)

# Getting Started
just clone the repo and run ga.m for genatic algorism or ga_multicrossover.m for for genatic algorism with Multi-Point Crossover 


[![Watch the video](https://img.youtube.com/vi/uUeU5cuFRA8/0.jpg)](https://youtu.be/uUeU5cuFRA8)













