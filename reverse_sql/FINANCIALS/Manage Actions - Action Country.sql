/* ****************************************************************************
 * $Revision: 78239 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 22:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Actions%20-%20Action%20Country.sql $:
 * $Id: Manage Actions - Action Country.sql 78239 2022-04-07 15:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

--RSC_PREREQUISITE_OBJECTS=PER_ACTIONS_VL

SELECT perACTIONEO.ACTION_CODE RES_ACTION_CODE
,perACTIONEO.ACTION_NAME RES_ACTION_NAME
,TO_CHAR(perACTIONEO.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,(SELECT TERRITORY_SHORT_NAME 
	FROM FND_TERRITORIES_VL 
	WHERE TERRITORY_CODE = (TRIM(REGEXP_SUBSTR(perACTIONEO.COUNTRY, '[^,]+', 1, levels.column_value)))
	) RES_COUNTRY
,'Yes' RES_ENABLE
,perACTIONEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,perACTIONEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,perACTIONEO.CREATED_BY  RSC_CREATED_BY
,perACTIONEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,TRIM(REGEXP_SUBSTR(perACTIONEO.COUNTRY, '[^,]+', 1, levels.column_value)) RSC_COUNTRY_ID
 FROM PER_ACTIONS_VL perACTIONEO
 ,table(cast(multiset(select level from dual connect by  level <= length (regexp_replace(perACTIONEO.COUNTRY, '[^,]+'))  + 1) as sys.OdciNumberList)) levels
 WHERE SYSDATE BETWEEN perACTIONEO.START_DATE AND NVL(perACTIONEO.END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
 AND perACTIONEO.COUNTRY IS NOT NULL
 ORDER BY perACTIONEO.ACTION_CODE
 ,RES_COUNTRY