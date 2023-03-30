/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Actions%20-%20Action%20Roles.sql $:
 * $Id: Manage Actions - Action Roles.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

--RSC_PREREQUISITE_OBJECTS=PER_ACTION_ROLE_MAPPING

 SELECT perACTIONEO.ACTION_CODE RES_ACTION_CODE
 ,perACTIONEO.ACTION_NAME RES_ACTION_NAME
 ,TO_CHAR(perACTIONEO.START_DATE,'DD-Mon-YYYY') RES_START_DATE
 ,TO_CHAR(perACTIONEO.END_DATE,'DD-Mon-YYYY')  RES_END_DATE
 ,(SELECT ROLE_NAME FROM PER_ROLES_DN_VL WHERE ROLE_COMMON_NAME = perACTIONROLEO.ROLE_COMMON_NAME) RES_ROLE
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
,NULL RSC_COUNTRY_ID

 
 FROM PER_ACTIONS_VL perACTIONEO
 ,PER_ACTION_ROLE_MAPPING perACTIONROLEO
 WHERE perACTIONEO.ACTION_ID = perACTIONROLEO.ACT_USG_ID
 AND perACTIONEO.ACTION_TYPE_CODE = perACTIONROLEO.ACTION_TYPE_CODE
 AND perACTIONROLEO.TYPE = 'ACTION'
 --AND SYSDATE BETWEEN perACTIONEO.START_DATE AND NVL(perACTIONEO.END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
 ORDER BY perACTIONEO.ACTION_CODE