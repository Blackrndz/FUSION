/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=HWM_TCATS_VL



SELECT geoHierarchiesE0.NAME RES_NAME
,geosE0.GEOGRAPHY_ELEMENT1 RES_COUNTRY_NAME
,(CASE
	WHEN GEOGRAPHY_TYPE = 'STATE' THEN
		geosE0.GEOGRAPHY_NAME||', '||geosE0.GEOGRAPHY_ELEMENT1
	WHEN GEOGRAPHY_TYPE = 'CITY' THEN
		geosE0.GEOGRAPHY_NAME||', '||geosE0.GEOGRAPHY_ELEMENT2
	END) RES_SUB_COUNTRY_NAME
,(CASE
	WHEN GEOGRAPHY_TYPE = 'STATE' THEN
		geosE0.GEOGRAPHY_NAME
	WHEN GEOGRAPHY_TYPE = 'CITY' THEN
		geosE0.GEOGRAPHY_ELEMENT2
	END) RES_PARENT_SUBLEVEL
,(CASE
	WHEN GEOGRAPHY_TYPE = 'CITY' THEN
		geosE0.GEOGRAPHY_NAME
	END) RES_SUBLEVEL
,geoHierarchiesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,geoHierarchiesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,geoHierarchiesE0.CREATED_BY  RSC_CREATED_BY
,geoHierarchiesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM IRC_GEO_HIERARCHIES geoHierarchiesE0
,IRC_GEO_HIER_NODES geoNodesE0
,HZ_GEOGRAPHIES geosE0
WHERE geoHierarchiesE0.HIERARCHY_ID = geoNodesE0.HIERARCHY_ID
AND geoNodesE0.GEOGRAPHY_ID = geosE0.GEOGRAPHY_ID
AND geosE0.GEOGRAPHY_TYPE != 'COUNTRY'
ORDER BY geoHierarchiesE0.NAME
,geosE0.GEOGRAPHY_NAME