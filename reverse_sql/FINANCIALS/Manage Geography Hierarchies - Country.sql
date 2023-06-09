/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2018-03-20  $:
 * $HeadURL: $:
 * $Id: Configure Exception Sets - Exception  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
--RSC_PREREQUISITE_OBJECTS=IRC_GEO_HIERARCHIES
--RSC_PREREQUISITE_OBJECTS=IRC_GEO_HIER_NODES

WITH tmpTREE AS (
	SELECT HIERARCHY_ID,GEOGRAPHY_NODE_ID,LAST_UPDATED_BY,LAST_UPDATE_DATE,CREATED_BY,CREATION_DATE
	,SUBSTR(SYS_CONNECT_BY_PATH(GEOGRAPHY_ID,'#'),INSTR(SYS_CONNECT_BY_PATH(GEOGRAPHY_ID,'#'),'#',-1,1)+1,LENGTH(SYS_CONNECT_BY_PATH(GEOGRAPHY_ID,'#'))-INSTR(SYS_CONNECT_BY_PATH(GEOGRAPHY_ID,'#'),'#')) CHILD_VALUES
	,SUBSTR(SYS_CONNECT_BY_PATH(GEOGRAPHY_ID,'#'),INSTR(SYS_CONNECT_BY_PATH(GEOGRAPHY_ID,'#'),'#',-1,2)+1,INSTR(SYS_CONNECT_BY_PATH(GEOGRAPHY_ID,'#'),'#',-1,1)-(INSTR(SYS_CONNECT_BY_PATH(GEOGRAPHY_ID,'#'),'#',-1,2)+1)) PARENT_VALUES
	,LEVEL LVL
	FROM IRC_GEO_HIER_NODES 
	START WITH PARENT_GEO_NODE_ID IS NULL
	CONNECT BY PRIOR GEOGRAPHY_NODE_ID = PARENT_GEO_NODE_ID
)

SELECT geoHierarchiesE0.NAME RES_NAME
,(SELECT GEOGRAPHY_NAME FROM HZ_GEOGRAPHIES WHERE GEOGRAPHY_ID = geoNodesE0.PARENT_VALUES
	AND SYSDATE BETWEEN START_DATE AND END_DATE) RES_PARENT_COUNTRY_NAME
,(SELECT GEOGRAPHY_CODE FROM HZ_GEOGRAPHIES WHERE GEOGRAPHY_ID = geoNodesE0.PARENT_VALUES 
	AND SYSDATE BETWEEN START_DATE AND END_DATE) RES_PARENT_CODE
,(SELECT GEOGRAPHY_NAME FROM HZ_GEOGRAPHIES WHERE GEOGRAPHY_ID = geoNodesE0.CHILD_VALUES
	AND SYSDATE BETWEEN START_DATE AND END_DATE)  RES_COUNTRY_NAME
,(SELECT GEOGRAPHY_CODE FROM HZ_GEOGRAPHIES WHERE GEOGRAPHY_ID = geoNodesE0.CHILD_VALUES 
	AND SYSDATE BETWEEN START_DATE AND END_DATE) RES_CODE

,geoNodesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,geoNodesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,geoNodesE0.CREATED_BY  RSC_CREATED_BY
,geoNodesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


FROM IRC_GEO_HIERARCHIES geoHierarchiesE0
,tmpTREE geoNodesE0
WHERE geoHierarchiesE0.HIERARCHY_ID = geoNodesE0.HIERARCHY_ID
ORDER BY geoHierarchiesE0.NAME,LVL