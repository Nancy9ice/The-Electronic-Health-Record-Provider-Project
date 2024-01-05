{% docs __overview__ %}
# Welcome!
Welcome to the documentation for the dbt project of this fictional Electronic Health Record Provider Organization!

# Navigation
You can use the Project and Database navigation tabs on the left side of the window to explore the models in this project.

# Project Tab
The Project tab mirrors the directory structure of this dbt project. In this tab, you can see all of the models defined in the dbt project, as well as models imported from dbt packages.

# Database Tab
The Database tab also exposes the models, but in a format that looks more like a database explorer. This view shows relations (tables and views) grouped into database schemas. Note that ephemeral models are not shown in this interface, as they do not exist in the database.

# Graph Exploration
You can click the blue icon on the bottom-right corner of the page to view the lineage graph of the models.

On model pages, you'll see the immediate parents and children of the model you're exploring. By clicking the Expand button at the top-right of this lineage pane, you'll be able to see all of the models that are used to build, or are built from, the model you're exploring.

Once expanded, you'll be able to use the --select and --exclude model selection syntax to filter the models in the graph.

Note that you can also right-click on models to interactively filter and explore the graph.


---

# More Information
View the **[github repo](https://github.com/Nancy9ice/The-Electronic-Health-Record-Provider-Project)**

{% enddocs %}

