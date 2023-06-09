/* ****************************************************************************
* $Revision: 72658 $:
* $Author: tanawat.wongjan $:
* $Date: 2019-10-01 15:00:45 +0700 (Tue, 01 Oct 2019) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/Manage%20SCM%20Common%20Value%20Sets%20-%20Manage%20SCM%20Common%20Value%20Sets.sql $:
* $Id: Manage SCM Common Value Sets - Manage SCM Common Value Sets.sql 55804 2016-06-09 04:17:45Z wuttipong.thongvises
$:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=CMP_TCS_CAT_VL

WITH GRANT_TYPES_ALL AS (SELECT CAT_ID
	,STOCK_GRANT_TYPE_CD||',' STOCK_GRANT_TYPE
	FROM CMP_TCS_CAT_VL
	WHERE STOCK_GRANT_TYPE_CD IS NOT NULL)
,GRANT_TYPES AS (SELECT CAT_ID
	,1 SEQ
	,TRIM(SUBSTR(STOCK_GRANT_TYPE,1,INSTR(STOCK_GRANT_TYPE,',',1,1)-1)) GRANT_TYPES
	FROM GRANT_TYPES_ALL
	
	UNION
	
	SELECT CAT_ID
	,2 SEQ
	,TRIM(SUBSTR(STOCK_GRANT_TYPE,INSTR(STOCK_GRANT_TYPE,',',1,1)+1,INSTR(STOCK_GRANT_TYPE,',',1,2) - INSTR(STOCK_GRANT_TYPE,',',1,1) - 1)) GRANT_TYPES
	FROM GRANT_TYPES_ALL
	
	UNION
	
	SELECT CAT_ID
	,3 SEQ
	,TRIM(SUBSTR(STOCK_GRANT_TYPE,INSTR(STOCK_GRANT_TYPE,',',1,2)+1,INSTR(STOCK_GRANT_TYPE,',',1,3) - INSTR(STOCK_GRANT_TYPE,',',1,2) - 1)) GRANT_TYPES
	FROM GRANT_TYPES_ALL
	
	UNION
	
	SELECT CAT_ID
	,4 SEQ
	,TRIM(SUBSTR(STOCK_GRANT_TYPE,INSTR(STOCK_GRANT_TYPE,',',1,3)+1,INSTR(STOCK_GRANT_TYPE,',',1,4) - INSTR(STOCK_GRANT_TYPE,',',1,3) - 1)) GRANT_TYPES
	FROM GRANT_TYPES_ALL
	
	UNION
	
	SELECT CAT_ID
	,5 SEQ
	,TRIM(SUBSTR(STOCK_GRANT_TYPE,INSTR(STOCK_GRANT_TYPE,',',1,4)+1,INSTR(STOCK_GRANT_TYPE,',',1,5) - INSTR(STOCK_GRANT_TYPE,',',1,4) - 1)) GRANT_TYPES
	FROM GRANT_TYPES_ALL
	
	UNION
	
	SELECT CAT_ID
	,6 SEQ
	,TRIM(SUBSTR(STOCK_GRANT_TYPE,INSTR(STOCK_GRANT_TYPE,',',1,5)+1,INSTR(STOCK_GRANT_TYPE,',',1,6) - INSTR(STOCK_GRANT_TYPE,',',1,5) - 1)) GRANT_TYPES
	FROM GRANT_TYPES_ALL
	
	UNION
	
	SELECT CAT_ID
	,7 SEQ
	,TRIM(SUBSTR(STOCK_GRANT_TYPE,INSTR(STOCK_GRANT_TYPE,',',1,6)+1,INSTR(STOCK_GRANT_TYPE,',',1,7) - INSTR(STOCK_GRANT_TYPE,',',1,6) - 1)) GRANT_TYPES
	FROM GRANT_TYPES_ALL
	
	UNION
	
	SELECT CAT_ID
	,8 SEQ
	,TRIM(SUBSTR(STOCK_GRANT_TYPE,INSTR(STOCK_GRANT_TYPE,',',1,7)+1,INSTR(STOCK_GRANT_TYPE,',',1,8) - INSTR(STOCK_GRANT_TYPE,',',1,7) - 1)) GRANT_TYPES
	FROM GRANT_TYPES_ALL
	
	UNION
	
	SELECT CAT_ID
	,9 SEQ
	,TRIM(SUBSTR(STOCK_GRANT_TYPE,INSTR(STOCK_GRANT_TYPE,',',1,8)+1,INSTR(STOCK_GRANT_TYPE,',',1,9) - INSTR(STOCK_GRANT_TYPE,',',1,8) - 1)) GRANT_TYPES
	FROM GRANT_TYPES_ALL
	
	UNION
	
	SELECT CAT_ID
	,10 SEQ
	,TRIM(SUBSTR(STOCK_GRANT_TYPE,INSTR(STOCK_GRANT_TYPE,',',1,9)+1,INSTR(STOCK_GRANT_TYPE,',',1,10) - INSTR(STOCK_GRANT_TYPE,',',1,9) - 1)) GRANT_TYPES
	FROM GRANT_TYPES_ALL)


SELECT compCatsE0.NAME RES_CATEGORY_NAME
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'CMP_TCS_LEVEL_OF_DETAIL'
	AND LOOKUP_CODE = compCatsE0.LEVEL_OF_DETAIL
	) RES_LEVEL_OF_DETAIL
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'CMP_STOCK_GRANT_TYPE'
	AND LOOKUP_CODE = grantTypesE0.GRANT_TYPES
	) RES_GRANT_TYPE
,compCatsE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,compCatsE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,compCatsE0.CREATED_BY RSC_CREATED_BY
,compCatsE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM CMP_TCS_CAT_VL compCatsE0
,GRANT_TYPES grantTypesE0
WHERE compCatsE0.CAT_TYPE_CD NOT LIKE '%SECTION'
AND compCatsE0.CAT_ID = grantTypesE0.CAT_ID
AND grantTypesE0.GRANT_TYPES IS NOT NULL
ORDER BY compCatsE0.NAME
,grantTypesE0.SEQ