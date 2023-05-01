# Maze A*

Xcode project relating to an iOS application for maze solving using [A* pathfinding](https://en.wikipedia.org/wiki/A*_search_algorithm).

A* (pronounced 'A-star') is a path search algorithm used to find the shortest path from a starting point to a goal.  With `n` being the next node on the path, A* selects the path that minimizes : $$f(n) = g(n) + h(n)$$
- $g(n)$ is the cost of the path from the start point to n
- $h(n)$ is a heuristic function that estimates the cost of the cheapest path from n to the goal

Note that the Manhattan distance is the heuristic function chosen for this project. In addition, the authorized movements on the maze are only vertical and horizontal ones.

## Usage

Open the `NewsApp.xcodeproj` file with Xcode and build the application in the simulator or on a device.

## Available features

- **Add** : create your own maze by defining the number of rows / columns & the position of start / goal
- **Customize** : add or remove walls from the maze
- **Save** : store your maze
- **Load** : retrieve your stored mazes
- **Solve** : watch A* in action solving your maze
