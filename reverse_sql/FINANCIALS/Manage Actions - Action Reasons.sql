/* ****************************************************************************
 * $Revision: 80046 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2023-01-30 15:50:50 +0700 (Mon, 30 Jan 2023) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Actions%20-%20Action%20Reasons.sql $:
 * $Id: Manage Actions - Action Reasons.sql 80046 2023-01-30 08:50:50Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT perACTIONEO.ACTION_CODE RES_ACTION_CODE
,perACTIONEO.ACTION_NAME RES_ACTION_NAME
,TO_CHAR(perACTIONEO.START_DATE,'DD-Mon-YYYY') RES_ACTION_START_DATE
,perACTIONREUSAEO.ACTION_REASON_CODE RES_ACTION_REASON_CODE
,(SELECT ACTION_REASON 
	FROM PER_ACTION_REASONS_VL 
	WHERE ACTION_REASON_ID  = perACTIONREUSAEO.ACTION_REASON_ID 
	AND SYSDATE BETWEEN START_DATE AND END_DATE
	) RES_ACTION_REASON_NAME
,TO_CHAR(perACTIONREUSAEO.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(perACTIONREUSAEO.END_DATE,'DD-Mon-YYYY')  RES_END_DATE
,perACTIONREUSAEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,perACTIONREUSAEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,perACTIONREUSAEO.CREATED_BY  RSC_CREATED_BY
,perACTIONREUSAEO.CREATION_DATE  RSC_CREATION_DATE
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
WHERE perACTIONEO.ACTION_ID = perACTIONREUSAEO.ACTION_ID
--AND SYSDATE BETWEEN perACTIONEO.START_DATE AND NVL(perACTIONEO.END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY'))
AND SYSDATE BETWEEN perACTIONREUSAEO.START_DATE AND NVL(perACTIONREUSAEO.END_DATE,TO_DATE('31-12-4712','DD-MM-YYYY')) 
ORDER BY perACTIONEO.ACTION_CODE