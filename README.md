# Economic dispatch simulator

This is a proof of concept regarding the way electricity companies dispatch energy to the grid depending on the expected load by hour. This is done using Lagrange Multipliers applied to the models (usually quadratic) of the power generation plants. This aims to increase or decrease the generation of electricity for each expected load incurring in the minimum incrimental cost, this is achieved by having every generation plant at the same differential cost while considering the minimum and maximum load capacities for each plant.

The project is hosted in: [economic_dispatch](https://luislundquist.shinyapps.io/economic_dispatch/)

- *Power Generation Data tab*: Allows user to change the requested loads from the plants, at the right the user can appreciate how as the load changes, the generation changes too, and each change is different depending on the current status as well as the goal status

- *Load Profiles tab*: An hourly load profile is randomly generated each time the application is loaded. In the first plot we see the profile for each plant depending on the load requested at an specific hour. The plot below shows the combined contributions of each plant to achieve the total demand.

- *Load Calculation tab*: An hourly load was simulated for an entire year, taking into account factos such as month, weekday, hour, temperature and a random variable. With this information then it aims to predict the load. The first plot is the load profile generated, the second one is the point by point comparation of actual data versus prediction (a straight 45º line would be perfect prediction). The prediction is not far off. This was done with linear regression.

Files:
- **ui.R**: is the user interface configuration, it sets how the app is visualized and interacted with.
- **server.R** this file is the flow control of the application, receiving the inputs from ui.R and generating outputs to it.
- **global.R**: This is an auxiliary file where some functions are defined to be later called by global.R
    
