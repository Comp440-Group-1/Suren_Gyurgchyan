
-- Create table statements
CREATE TABLE address
       (      address_id     int     identity(1,1) not null,
              street         varchar(100)          not null,
              city           varchar(100)           not null,
              state          char(2)    not null,
              zip            char(5)    not null,
              CONSTRAINT pk_address_id PRIMARY KEY (address_id)
	 );  

CREATE TABLE customer
(
cust_id int identity(1,1) NOT NULL,
name varchar(100) NOT NULL,
company varchar(100),
email varchar(100),
phone varchar(15),
address_id int,
CONSTRAINT pk_cust_id PRIMARY KEY (cust_id),
CONSTRAINT fk_address_id FOREIGN KEY(address_id)
REFERENCES address(address_id)
);
	 
CREATE TABLE product
       (      product_id     int     identity(1,1) not null,
              name           varchar(100)    not null,
              CONSTRAINT pk_product_id PRIMARY KEY (product_id)
       );
       
CREATE TABLE featureType
       (      featureType_id     int   identity(1,1)  not null,
              type               varchar(100)    not null,
              CONSTRAINT pk_featureType_id PRIMARY KEY (featureType_id)
        );   


CREATE TABLE features
       (      feature_id     int   identity(1,1) not null,
			  featureType_id int not null,
			  product_id int not null,
              description    varchar(100)    not null,
			  CONSTRAINT pk_feature_id PRIMARY KEY (feature_id),
              CONSTRAINT fk_product_id FOREIGN KEY(product_id)
			  REFERENCES product(product_id),
			  CONSTRAINT fk_featureType_id FOREIGN KEY(featureType_id)
			  REFERENCES featureType(featureType_id)
        );
        
CREATE TABLE releaseType
       (      releaseType_id     int     identity(1,1) not null,
              type               varchar(50)    not null,
              CONSTRAINT pk_releaseType_id PRIMARY KEY (releaseType_id)
        );  
        
  CREATE TABLE release
       (      release_id     int     identity(1,1) not null,
              releaseType_id int not null,
              product_id int not null,
              version        varchar(50)    not null,
              date           date  ,
              stability      bit    not null,
              CONSTRAINT pk_release_id PRIMARY KEY (release_id),
              CONSTRAINT fk_product_id FOREIGN KEY(product_id)
			  REFERENCES product(product_id),
			  CONSTRAINT fk_releaseType_id FOREIGN KEY(releaseType_id)
			  REFERENCES releaseType(releaseType_id)
        );  
        
CREATE TABLE sourceControl
       (      sourceControl_id     int    identity(1,1) not null,
              release_id int not null,
              CONSTRAINT pk_sourceControl_id PRIMARY KEY (sourceControl_id),
              CONSTRAINT fk_release_id FOREIGN KEY(release_id)
			  REFERENCES release(release_id)
        );
CREATE TABLE downloadLink
       (      downloadLink_id     int      identity(1,1) not null,
              release_id int not null,
              url                 varchar(10)     not null,
              CONSTRAINT pk_downloadLink_id PRIMARY KEY (downloadLink_id),
              CONSTRAINT fk_download_release_id FOREIGN KEY(release_id)
			  REFERENCES release(release_id)
        );
        
CREATE TABLE download
       (      download_id    int identity(1,1) not null,
              cust_id    int not null,
              downloadLink_id int not null,
              downloadDate date not null,
              CONSTRAINT pk_downloads_id PRIMARY KEY (download_id),
              CONSTRAINT fk_cust_id FOREIGN KEY(cust_id)
			  REFERENCES customer(cust_id),
              CONSTRAINT fk_downloadLink_id FOREIGN KEY(downloadLink_id)
			  REFERENCES downloadLink(downloadLink_id)    
        );        



-- create user and  grant privileges


CREATE LOGIN admin1 WITH PASSWORD = 'admin123';

CREATE USER admin FOR LOGIN admin1;

GRANT ALL ON SCHEMA ::s16guest09 TO admin;


/*Database Schema
 Address(AddressID,street,city,state,zip)
 Customer(CustID,Name,email,phone,AddressID)
 Product(ProductID,name)
 FeautureType(FeautureTypeID,Type)
 Feature(FeatureID,FeatureTypeID,ProductID,description)
 ReleaseType(ReleaseTypeID,Type)
 Release(ReleaseID,releaseType_id, ProductID,version,date,stability)
 SourceControl(SourceControlID,ReleaseID)
 DownloadLink(downloadLink_id,url)
 Download(downloadID,customerID, downloadLink_id, downloadDate)     */   
 
 
 