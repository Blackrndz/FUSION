/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Actions%20-%20Action%20Reason%20Roles.sql $:
 * $Id: Manage Actions - Action Reason Roles.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

--RSC_PREREQUISITE_OBJECTS=PER_ACTION_ROLE_MAPPING

 SELECT perACTIONEO.ACTION_CODE RES_ACTION_CODE
 ,perACTIONEO.ACTION_NAME RES_ACTION_NAME
 ,TO_CHAR(perACTIONEO.START_DATE,'DD-Mon-YYYY') RES_START_DATE
 ,perACTIONREUSAEO.ACTION_REASON_CODE RES_ACTION_REASON_CODE
 ,(SELECT ACTION_REASON FROM PER_ACTION_REASONS_VL WHERE ACTION_REASON_ID  = perACTIONREUSAEO.ACTION_REASON_ID 
	AND SYSDATE BETWEEN START_DATE AND END_DATE) RES_ACTION_REASON_NAME
 ,(SELECT ROLE_NAME FROM PER_ROLES_DN_VL WHERE ROLE_COMMON_NAME = perACTIONROLEO.ROLE_COMMON_NAME) RES_ROLE
 ,'Yes' RES_ENABLE
 
  ,perACTIONROLEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,perACTIONROLEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,perACTIONROLEO.CREATED_BY  RSC_CREATED_BY
  ,perACTIONROLEO.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

 
 FROM PER_ACTIONS_VL perACTIONEO
 ,PER_ACTION_REASON_USAGES perACTIONREUSAEO
 ,PER_ACTION_ROLE_MAPPING perACTIONROLEO
WHERE perACTIONEO.ACTION_ID = perACTIONREUSAEO.ACTION_ID
AND perACTIONREUSAEO.ACTION_REASON_USAGE_ID = perACTIONROLEO.ACT_USG_ID
AND perACTIONEO.ACTION_TYPE_CODE = perACTIONROLEO.ACTION_TYPE_CODE
AND perACTIONROLEO.TYPE = 'USAGE'
--AND SYSDATE BETWEEN perACTIONEO.START_DATE AND NVL(perACTIONEO.END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
AND SYSDATE BETWEEN perACTIONREUSAEO.START_DATE AND NVL(perACTIONREUSAEO.END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY')) 

ORDER BY perACTIONEO.ACTION_CODE