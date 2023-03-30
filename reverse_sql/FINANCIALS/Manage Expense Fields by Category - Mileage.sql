/* ****************************************************************************
* $Revision: 61485 $:
* $Author: chanatip.buabhom $:
* $Date: 2017-03-21 17:10:25 +0700 (Tue, 21 Mar 2017) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/customized/In%20Develop/reverse_sql/Manage%20Expense%20Fields%20by%20Category%20-%20Mileage.sql $:
* $Id: Manage Expense Fields by Category - Mileage.sql 61485 2017-03-21 10:10:25Z chanatip.buabhom $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT 'Yes' RES_ENABLE_FIELDS_FOR_MILEAGE
,BUSINESSUNITPEO.BU_NAME RES_BUSINESS_UNIT
,DECODE(CATEGORYFIELDEO.LOCATION_TO_FIELD,'ENABLED','Optional','DISABLED','Hidden','REQUIRED','Required')
	RES_STARTING_LOCATION
,DECODE(CATEGORYFIELDEO.LOCATION_FROM_FIELD,'ENABLED','Optional','DISABLED','Hidden','REQUIRED','Required')
	RES_DESTINATION
,DECODE(CATEGORYFIELDEO.LICENSE_PLATE_FIELD,'ENABLED','Optional','DISABLED','Hidden','REQUIRED','Required')
	RES_LICENSE_PLATE_NUMBER
,DECODE(CATEGORYFIELDEO.STARTING_ODOMETER_FIELD,'ENABLED','Optional','DISABLED','Hidden','REQUIRED','Required')
	RES_STARTING_ODOMETER_READING
,DECODE(CATEGORYFIELDEO.ENDING_ODOMETER_FIELD,'ENABLED','Optional','DISABLED','Hidden','REQUIRED','Required')
	RES_ENDING_ODOMETER_READING
,CategoryFieldEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,CategoryFieldEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,CategoryFieldEO.CREATED_BY RSC_CREATED_BY
,CategoryFieldEO.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,CATEGORYFIELDEO.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM EXM_CATEGORY_FIELDS CategoryFieldEO
,FUN_ALL_BUSINESS_UNITS_V BusinessUnitPEO
WHERE CATEGORYFIELDEO.ORG_ID = BUSINESSUNITPEO.BU_ID
AND Category_code            = 'MILEAGE'
order by BUSINESSUNITPEO.BU_NAME