# The Electronic Health Record Provider

*This project was implemented using Microsoft Fabric (Fabric Data Factory and Fabric Data Warehouse) and dbt.*

## Background
The government of the Republic of Narnia are concerned about the fragmented patient records across several hospitals. This fragmentation have caused more harm than good including the inability of patients to move through different hospitals without the re-registration of these patients. Hence, they are asking the Nancy9ice Consulting firm to build a centralized warehouse to house all available hospitals and patients in the Republic of Narnia. 

There's some available data based on records already gathered from some hospitals. However, this data is not yet complete. In anticipation of more records, they are asking that provisions be made for the updated records to be read into the warehouse that will be built for easy management.

## Business Objectives
- Create a centralized warehouse to consolidate patient records from various hospitals across the Republic of Narnia.

- Integrate existing patient records from participating hospitals into the centralized warehouse, ensuring that historical data is included for a comprehensive view of each patient's medical history.

- Develop a robust patient identity management system to prevent duplication and ensure accurate matching of patient records. This will eliminate the need for patients to re-register when moving between hospitals.

- Design the centralized warehouse to be scalable, anticipating an increase in data volume as more hospitals contribute records.

- Implement data quality assurance measures to validate and cleanse incoming data.

## Data
The data is a csv file in a [Google drive folder](https://drive.google.com/drive/folders/1kk_2bF-HZbBGPPYjo2BfP5FN53FLvwM2?usp=sharing) that contains upto 20,000 records.

## Implementation Approach
Considering the outlined business objectives, the chosen approach was the Extract Load Transform (ELT) methodology. This decision was particularly chosen due to the emphasis on scalability and the anticipation of increasing complexity in hospital records, which may lead to variations in data structures in the future. 

- Business problem understanding

- Built a **data pipeline** from google drive into the **Microsoft Fabric Warehouse** using **Microsoft Fabric Data Factory**

- Transformed and modeled the data on the warehouse using **dbt**

- Implemented **model testing** using **dbt** to verify the accuracy, consistency, and reliability of the transformed data.

- Documented the models in the warehouse

## Architecture

![](dbt-fabric/ELT%20Architecture.png)

## Direct Acyclic Graph
The image below shows the relationship between the models developed in the Microsoft Fabric Data Warehouse. 

![](dbt-fabric/DAG.PNG)

## Model Documentation
[Click to view the Project Documentation](https://nancy9ice.github.io/The-Electronic-Health-Record-Provider-Project/)

## Setup
To replicate the models developed on the Microsoft Fabric Warehouse, follow the following steps:

- Add the [data](https://drive.google.com/drive/folders/1kk_2bF-HZbBGPPYjo2BfP5FN53FLvwM2?usp=sharing) to your data warehouse on Microsoft Fabric

- Fork this repo

- Adjust the profiles.yml file based on the credentials of your warehouse

- Run dbt build
