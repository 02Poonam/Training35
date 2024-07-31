**Jenkins Basic Freestyle project**  

- Jenkins Dashboard

![](img1.png)

- By clicking on **New Item** we can create a new project and then we can see the following screen

![](img2.png)

- So here I have created this project named Demo\_app.

Then we can select which type of project it is whether it is Freestyle project or a Pipeline or a Multi- configuration project and so on.

Then we can click on **OK.**

- Then we will need to do configuration of our project.

![](img3.png)

Add a description for your project.

![](img4.png)

In source code management, add Git repository path

![](img5.png)

- We can add which branch do build 

![](img6.png)

- Build Triggers and schedule the build.

![](img7.png)

- Add **Build Environment** and **Build Steps**

![](img8.png)

- We can also add **post build actions** if needed. 

Then **Save.**

![](img9.png)

Once created a project you can build the project by clicking on **Build Now**

![](img10.png)

We can see the **Build History** of the project.

![](img11.png)

The **Build Status** of the project

**Console output**

![](img12.png)

![](img13.png)

- **We can also configure the project and build the project again.**

![](img14.png)

![](img15.png)

**Changed** the branch to **featured** and **updated** the **build trigger.**

![](img16.png)

Build history before changing the build trigger

![](img17.png)

Build history after changing build trigger.

**Console Output**

![](img18.png)

![](img19.png)

**Building a pipeline between 2 projects: Dev Compile & Dev Test** First created a **Dev Compile** project with a goal to **compile** the project

![](img20.png)

Added credentials for pulling a private git repo.

![](img21.png)

Added the Maven version and goal **compile** and to build steps
