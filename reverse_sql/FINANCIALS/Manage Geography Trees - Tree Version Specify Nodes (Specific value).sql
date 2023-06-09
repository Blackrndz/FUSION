/* ****************************************************************************
 * $Revision: 71762 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2019-04-03 15:23:08 +0700 (Wed, 03 Apr 2019) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Manage%20Organization%20Trees%20-%20Tree%20Version%20Specify%20Nodes%20(Specific%20value).sql $:
 * $Id: Manage Organization Trees - Tree Version Specify Nodes (Specific value).sql 71762 2019-04-03 08:23:08Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT cutOff.TREE_NAME			RES_TREE_NAME
,cutOff.TREE_CODE				RES_TREE_CODE
,cutOff.TREE_STRUCTURE_CODE 	RES_TREE_STRUCTURE_CODE
,cutOff.TREE_VERSION_NAME		RES_NAME
,'Specific value' 			RES_TREE_NODE_TYPE
,(SELECT DATA_SOURCE_NAME 
	FROM FND_TS_DATA_SOURCE_VL
	WHERE DATA_SOURCE_ID = cutOff.DATA_SOURCE_ID
	AND TREE_STRUCTURE_CODE = cutOff.TREE_STRUCTURE_CODE
	) RES_DATA_SOURCE
,(CASE
	WHEN PARENT_VALUE_2_1 = 'PER_CAL_TOP_SCOPES' THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'PER_CAL_TOP_SCOPES'
			AND LOOKUP_CODE = RES_PARENT_DISPLAY_CODE1)
	WHEN PARENT_VALUE_2_1 IS NULL THEN
		(SELECT TERRITORY_CODE||' '||TERRITORY_SHORT_NAME
			FROM FND_TERRITORIES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND TERRITORY_CODE = RES_PARENT_DISPLAY_CODE1)
	WHEN PARENT_VALUE_3_1 = 'ORA_PER_GEOGRAPHIC_TREE_NODES' THEN 
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ORA_PER_GEOGRAPHIC_TREE_NODES'
			AND LOOKUP_CODE = RES_PARENT_DISPLAY_CODE1)
	END) RES_PARENT_NODE_NAME_1
,(CASE
	WHEN PARENT_VALUE_2_2 = 'PER_CAL_TOP_SCOPES' THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'PER_CAL_TOP_SCOPES'
			AND LOOKUP_CODE = RES_PARENT_DISPLAY_CODE2)
	WHEN PARENT_VALUE_2_2 IS NULL THEN
		(SELECT TERRITORY_CODE||' '||TERRITORY_SHORT_NAME
			FROM FND_TERRITORIES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND TERRITORY_CODE = RES_PARENT_DISPLAY_CODE2)
	WHEN PARENT_VALUE_3_2 = 'ORA_PER_GEOGRAPHIC_TREE_NODES' THEN 
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ORA_PER_GEOGRAPHIC_TREE_NODES'
			AND LOOKUP_CODE = RES_PARENT_DISPLAY_CODE2)
	END) RES_PARENT_NODE_NAME_2
,(CASE
	WHEN PARENT_VALUE_2_3 = 'PER_CAL_TOP_SCOPES' THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'PER_CAL_TOP_SCOPES'
			AND LOOKUP_CODE = RES_PARENT_DISPLAY_CODE3)
	WHEN PARENT_VALUE_2_3 IS NULL THEN
		(SELECT TERRITORY_CODE||' '||TERRITORY_SHORT_NAME
			FROM FND_TERRITORIES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND TERRITORY_CODE = RES_PARENT_DISPLAY_CODE3)
	WHEN PARENT_VALUE_3_3 = 'ORA_PER_GEOGRAPHIC_TREE_NODES' THEN 
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ORA_PER_GEOGRAPHIC_TREE_NODES'
			AND LOOKUP_CODE = RES_PARENT_DISPLAY_CODE3)
	END) RES_PARENT_NODE_NAME_3
,(CASE
	WHEN PARENT_VALUE_2_4 = 'PER_CAL_TOP_SCOPES' THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'PER_CAL_TOP_SCOPES'
			AND LOOKUP_CODE = RES_PARENT_DISPLAY_CODE4)
	WHEN PARENT_VALUE_2_4 IS NULL THEN
		(SELECT TERRITORY_CODE||' '||TERRITORY_SHORT_NAME
			FROM FND_TERRITORIES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND TERRITORY_CODE = RES_PARENT_DISPLAY_CODE4)
	WHEN PARENT_VALUE_3_4 = 'ORA_PER_GEOGRAPHIC_TREE_NODES' THEN 
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ORA_PER_GEOGRAPHIC_TREE_NODES'
			AND LOOKUP_CODE = RES_PARENT_DISPLAY_CODE4)
	END) RES_PARENT_NODE_NAME_4
,(CASE
	WHEN PARENT_VALUE_2_5 = 'PER_CAL_TOP_SCOPES' THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'PER_CAL_TOP_SCOPES'
			AND LOOKUP_CODE = RES_PARENT_DISPLAY_CODE5)
	WHEN PARENT_VALUE_2_5 IS NULL THEN
		(SELECT TERRITORY_CODE||' '||TERRITORY_SHORT_NAME
			FROM FND_TERRITORIES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND TERRITORY_CODE = RES_PARENT_DISPLAY_CODE5)
	WHEN PARENT_VALUE_3_5 = 'ORA_PER_GEOGRAPHIC_TREE_NODES' THEN 
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ORA_PER_GEOGRAPHIC_TREE_NODES'
			AND LOOKUP_CODE = RES_PARENT_DISPLAY_CODE5)
	END) RES_PARENT_NODE_NAME_5
,(CASE
	WHEN PARENT_VALUE_2_6 = 'PER_CAL_TOP_SCOPES' THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'PER_CAL_TOP_SCOPES'
			AND LOOKUP_CODE = RES_PARENT_DISPLAY_CODE6)
	WHEN PARENT_VALUE_2_6 IS NULL THEN
		(SELECT TERRITORY_CODE||' '||TERRITORY_SHORT_NAME
			FROM FND_TERRITORIES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND TERRITORY_CODE = RES_PARENT_DISPLAY_CODE6)
	WHEN PARENT_VALUE_3_6 = 'ORA_PER_GEOGRAPHIC_TREE_NODES' THEN 
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ORA_PER_GEOGRAPHIC_TREE_NODES'
			AND LOOKUP_CODE = RES_PARENT_DISPLAY_CODE6)
	END) RES_PARENT_NODE_NAME_6
,(CASE
	WHEN PARENT_VALUE_2_7 = 'PER_CAL_TOP_SCOPES' THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'PER_CAL_TOP_SCOPES'
			AND LOOKUP_CODE = RES_PARENT_DISPLAY_CODE7)
	WHEN PARENT_VALUE_2_7 IS NULL THEN
		(SELECT TERRITORY_CODE||' '||TERRITORY_SHORT_NAME
			FROM FND_TERRITORIES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND TERRITORY_CODE = RES_PARENT_DISPLAY_CODE7)
	WHEN PARENT_VALUE_3_7 = 'ORA_PER_GEOGRAPHIC_TREE_NODES' THEN 
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ORA_PER_GEOGRAPHIC_TREE_NODES'
			AND LOOKUP_CODE = RES_PARENT_DISPLAY_CODE7)
	END) RES_PARENT_NODE_NAME_7
,(CASE
	WHEN PARENT_VALUE_2_8 = 'PER_CAL_TOP_SCOPES' THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'PER_CAL_TOP_SCOPES'
			AND LOOKUP_CODE = RES_PARENT_DISPLAY_CODE8)
	WHEN PARENT_VALUE_2_8 IS NULL THEN
		(SELECT TERRITORY_CODE||' '||TERRITORY_SHORT_NAME
			FROM FND_TERRITORIES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND TERRITORY_CODE = RES_PARENT_DISPLAY_CODE8)
	WHEN PARENT_VALUE_3_8 = 'ORA_PER_GEOGRAPHIC_TREE_NODES' THEN 
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ORA_PER_GEOGRAPHIC_TREE_NODES'
			AND LOOKUP_CODE = RES_PARENT_DISPLAY_CODE8)
	END) RES_PARENT_NODE_NAME_8
,(CASE
	WHEN PARENT_VALUE_2_9 = 'PER_CAL_TOP_SCOPES' THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'PER_CAL_TOP_SCOPES'
			AND LOOKUP_CODE = RES_PARENT_DISPLAY_CODE9)
	WHEN PARENT_VALUE_2_9 IS NULL THEN
		(SELECT TERRITORY_CODE||' '||TERRITORY_SHORT_NAME
			FROM FND_TERRITORIES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND TERRITORY_CODE = RES_PARENT_DISPLAY_CODE9)
	WHEN PARENT_VALUE_3_9 = 'ORA_PER_GEOGRAPHIC_TREE_NODES' THEN 
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ORA_PER_GEOGRAPHIC_TREE_NODES'
			AND LOOKUP_CODE = RES_PARENT_DISPLAY_CODE9)
	END)  RES_PARENT_NODE_NAME_9
,(CASE
	WHEN PARENT_VALUE_2_10 = 'PER_CAL_TOP_SCOPES' THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'PER_CAL_TOP_SCOPES'
			AND LOOKUP_CODE = RES_PARENT_DISPLAY_CODE10)
	WHEN PARENT_VALUE_2_10 IS NULL THEN
		(SELECT TERRITORY_CODE||' '||TERRITORY_SHORT_NAME
			FROM FND_TERRITORIES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND TERRITORY_CODE = RES_PARENT_DISPLAY_CODE10)
	WHEN PARENT_VALUE_3_10 = 'ORA_PER_GEOGRAPHIC_TREE_NODES' THEN 
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ORA_PER_GEOGRAPHIC_TREE_NODES'
			AND LOOKUP_CODE = RES_PARENT_DISPLAY_CODE10)
	END) RES_PARENT_NODE_NAME_10
,(CASE
	WHEN PK2_START_VALUE = 'PER_CAL_TOP_SCOPES' THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'PER_CAL_TOP_SCOPES'
			AND LOOKUP_CODE = PK1_START_VALUE)
	WHEN PK2_START_VALUE IS NULL THEN
		(SELECT TERRITORY_CODE||' '||TERRITORY_SHORT_NAME
			FROM FND_TERRITORIES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND TERRITORY_CODE = PK1_START_VALUE)
	WHEN PK3_START_VALUE = 'ORA_PER_GEOGRAPHIC_TREE_NODES' THEN 
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ORA_PER_GEOGRAPHIC_TREE_NODES'
			AND LOOKUP_CODE = PK1_START_VALUE)
	END) RES_FULL_NODE_NAME_VALUE
,(CASE
	WHEN PK2_START_VALUE = 'PER_CAL_TOP_SCOPES' THEN
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'PER_CAL_TOP_SCOPES'
			AND LOOKUP_CODE = PK1_START_VALUE)
	WHEN PK2_START_VALUE IS NULL THEN
		(SELECT TERRITORY_CODE||' '||TERRITORY_SHORT_NAME
			FROM FND_TERRITORIES_TL
			WHERE LANGUAGE = USERENV('LANG')
			AND TERRITORY_CODE = PK1_START_VALUE)
	WHEN PK3_START_VALUE = 'ORA_PER_GEOGRAPHIC_TREE_NODES' THEN 
		(SELECT MEANING
			FROM FND_LOOKUP_VALUES
			WHERE LANGUAGE = USERENV('LANG')
			AND LOOKUP_TYPE = 'ORA_PER_GEOGRAPHIC_TREE_NODES'
			AND LOOKUP_CODE = PK1_START_VALUE)
	END) RES_NODE_NAME_VALUE 
,NULL RES_CLASSIFICATION_NAME
,cutOff.DESCRIPTION				RES_NODE_DESCRIPTION
,cutOff.LAST_UPDATED_BY   		RSC_LAST_UPDATED_BY
,cutOff.LAST_UPDATE_DATE  		RSC_LAST_UPDATE_DATE
,cutOff.CREATED_BY 				RSC_CREATED_BY
,cutOff.CREATION_DATE 			RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM (SELECT FndTreeVersionEO.EFFECTIVE_START_DATE
	,FndTreeVersionEO.EFFECTIVE_END_DATE
	,FndTreeVLEO.TREE_NAME
	,FndTreeVersionEO.DESCRIPTION
	,FndTreeVersionEO.TREE_VERSION_NAME
	,NODE.CREATION_DATE
	,NODE.CREATED_BY
	,NODE.LAST_UPDATE_DATE
	,NODE.LAST_UPDATED_BY
	,NODE.TREE_STRUCTURE_CODE
	,NODE.TREE_CODE TREE_CODE
	,NODE.TREE_VERSION_ID
	,NODE.TREE_NODE_ID
	,NODE.PK1_START_VALUE
	,NODE.PK2_START_VALUE
	,NODE.PK3_START_VALUE
	,NODE.DATA_SOURCE_ID
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,1)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,2)-4)  RES_PARENT_DISPLAY_CODE1
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,2)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,3) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,2)-3) RES_PARENT_DISPLAY_CODE2
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,3)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,4) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,3)-3) RES_PARENT_DISPLAY_CODE3
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,4)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,5) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,4)-3) RES_PARENT_DISPLAY_CODE4
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,5)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,6) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,5)-3) RES_PARENT_DISPLAY_CODE5
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,6)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,7) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,6)-3) RES_PARENT_DISPLAY_CODE6
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,7)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,8) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,7)-3) RES_PARENT_DISPLAY_CODE7
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,8)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,9) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,8)-3) RES_PARENT_DISPLAY_CODE8
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,9)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,10) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,9)-3) RES_PARENT_DISPLAY_CODE9
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,10)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,11) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK1_START_VALUE,'###'),'###',1,10)-3) RES_PARENT_DISPLAY_CODE10
	
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,1)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,2)-4)  PARENT_VALUE_2_1
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,2)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,3) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,2)-3) PARENT_VALUE_2_2
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,3)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,4) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,3)-3) PARENT_VALUE_2_3
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,4)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,5) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,4)-3) PARENT_VALUE_2_4
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,5)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,6) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,5)-3) PARENT_VALUE_2_5
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,6)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,7) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,6)-3) PARENT_VALUE_2_6
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,7)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,8) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,7)-3) PARENT_VALUE_2_7
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,8)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,9) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,8)-3) PARENT_VALUE_2_8
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,9)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,10) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,9)-3) PARENT_VALUE_2_9
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,10)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,11) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK2_START_VALUE,'###'),'###',1,10)-3) PARENT_VALUE_2_10
	
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,1)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,2)-4)  PARENT_VALUE_3_1
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,2)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,3) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,2)-3) PARENT_VALUE_3_2
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,3)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,4) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,3)-3) PARENT_VALUE_3_3
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,4)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,5) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,4)-3) PARENT_VALUE_3_4
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,5)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,6) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,5)-3) PARENT_VALUE_3_5
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,6)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,7) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,6)-3) PARENT_VALUE_3_6
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,7)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,8) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,7)-3) PARENT_VALUE_3_7
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,8)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,9) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,8)-3) PARENT_VALUE_3_8
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,9)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,10) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,9)-3) PARENT_VALUE_3_9
	,SUBSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,10)+3,INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,11) - INSTR(SYS_CONNECT_BY_PATH(NODE.PK3_START_VALUE,'###'),'###',1,10)-3) PARENT_VALUE_3_10

	FROM PER_GEO_TREE_NODE NODE
	,FND_TREE_VERSION_VL FndTreeVersionEO
	,FND_TREE_VL FndTreeVLEO
	WHERE NODE.TREE_STRUCTURE_CODE = 'PER_GEO_TREE_STRUCTURE'
	AND NODE.TREE_CODE = FndTreeVLEO.TREE_CODE
	AND NODE.TREE_STRUCTURE_CODE = FndTreeVLEO.TREE_STRUCTURE_CODE
	AND NODE.TREE_CODE = FndTreeVersionEO.TREE_CODE
	AND NODE.TREE_STRUCTURE_CODE = FndTreeVersionEO.TREE_STRUCTURE_CODE
	AND DEPTH <= 10
	AND (CHILD_COUNT = 0  OR (CHILD_COUNT > 0 and DEPTH <= 10 )) 
	START WITH NODE.PARENT_TREE_NODE_ID IS NULL
	CONNECT BY PRIOR NODE.TREE_NODE_ID = NODE.PARENT_TREE_NODE_ID
	) cutOff 
ORDER BY TREE_NAME
,RES_PARENT_NODE_NAME_1 NULLS FIRST,RES_PARENT_NODE_NAME_2 NULLS FIRST
,RES_PARENT_NODE_NAME_3 NULLS FIRST,RES_PARENT_NODE_NAME_4 NULLS FIRST
,RES_PARENT_NODE_NAME_5 NULLS FIRST,RES_PARENT_NODE_NAME_6 NULLS FIRST
,RES_PARENT_NODE_NAME_7 NULLS FIRST,RES_PARENT_NODE_NAME_8 NULLS FIRST
,RES_PARENT_NODE_NAME_9 NULLS FIRST,RES_PARENT_NODE_NAME_10 NULLS FIRST