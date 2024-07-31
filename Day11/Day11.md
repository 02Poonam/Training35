**Building a pipeline between 2 projects: Dev Compile & Dev Test** First created a **Dev Compile** project with a goal to **compile** the project

![alt text](img1.png)

Added credentials for pulling a private git repo.

![](img2.png)

Added the Maven version and goal **compile** and to build steps

Then created a **Dev Test** project with a goal to **test** the project

![](img3.png)

Enter credentials for the same private git repo

![](img4.png)

Added the Maven version and goal test** and to build steps

Now again configure the **Dev Compile** project and add the **Post Build Actions ->** Select **Build other projects ->** Select **Dev Test**

![](img5.png)

**Console Output of Dev Compile**

![](img6.png)

![](img7.png)

**Console output of Dev Test**

![](img8.png)

![](img9.png)
