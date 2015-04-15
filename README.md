# Miami Transit Api

A REST interface layer to expose Miami-Dade Transit API's and City of Miami Trolley Services Data

### API

- ```/api/:endpoint(.json, .xml)```

  Is a proxy and supports all endpoints documented here [Miami-Dade Transit WebServices](http://www.miamidade.gov/transit/WebServices/Transit_XML_Data_Feeds.pdf)
  
  **ie.**
  
  - http://www.miamidade.gov/transit/WebServices/MoverTrains/
    - http://miami-transit-api.herokuapp.com/api/MoverTrains.json
    
      Gets all Metromover Trains as json.

  - http://www.miamidade.gov/transit/WebServices/MoverTrains/?TrainID=101
    - https://miami-transit-api.herokuapp.com/api/MoverTrains.json?TrainID=101

      Will get a singular train.
  
  ***Note:***
  Always assume it is case-sensitive.

#### Status 
Currently in Alpha

#### Screenshots
![Infinite Windmills](http://i.giphy.com/MIY4jpusckRmU.gif)

## Why
Currently the Miami-Dade Transit API blocks outside access through an oversight in their CORs.
Making the use of that api in other applications difficult.

## Project setup

#### Dependencies
Ruby 2.2.0, Rails 4.2.0

#### OSX
- Install Brew
- Install RVM
- Install Ruby
- Install Rails
- Pull Repo
- Bundle
- ```rails server ```

Contacts
--------

* Chris Scott ([cyberstrike](https://github.com/cyberstrike))
* QTran ([QTranDev](https://github.com/qtrandev))
* Enide Dufresne ([enidedufresne](https://github.com/enidedufresne))
* Yami Medina ([yamilethmedina](https://github.com/tmaybe))


## License
A link to the Code for America copyright and [LICENSE.md file](https://github.com/codeforamerica/ceviche-cms/blob/master/LICENCE.md).
