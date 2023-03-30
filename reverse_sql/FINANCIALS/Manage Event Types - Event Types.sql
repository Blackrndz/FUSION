/* ****************************************************************************
 * $Revision: 72159 $:
 * $Author: tanawat.wongjan $:
 * $Date: 2019-05-31 16:44:21 +0700 (Fri, 31 May 2019) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.19/trunk/core/reverse_sql/FINANCIALS/Manage%20Document%20Types%20-%20Attributes.sql $:
 * $Id: Manage Document Types - Attributes.sql 72159 2019-05-31 09:44:21Z tanawat.wongjan $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=PJF_EVENT_TYPES_VL

SELECT eventTypesE0.EVENT_TYPE_NAME RES_EVENT_TYPE
,eventTypesE0.DESCRIPTION RES_DESCRIPTION
,(SELECT MEANING 
	FROM FND_LOOKUP_VALUES
	WHERE LANGUAGE = USERENV('LANG')
	AND LOOKUP_TYPE = 'PJF_REVENUE_CATEGORY'
	AND LOOKUP_CODE = eventTypesE0.REVENUE_CATEGORY_CODE
	) RES_REVENUE_CATEGORY
,DECODE(eventTypesE0.REVENUE_FLAG,'Y','Yes','No') RES_REVENUE
,DECODE(eventTypesE0.INVOICE_FLAG,'Y','Yes','No') RES_INVOICE
,DECODE(eventTypesE0.ALLOW_ADJUSTMENT_FLAG,'Y','Yes','No') RES_ALLOW_ADJUSTMENTS
,DECODE(eventTypesE0.MIGRATION_FLAG,'Y','Yes','No') RES_MIGRATION
,TO_CHAR(eventTypesE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(eventTypesE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
,eventTypesE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,eventTypesE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,eventTypesE0.CREATED_BY  RSC_CREATED_BY
,eventTypesE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_EVENT_TYPES_VL eventTypesE0
ORDER BY eventTypesE0.EVENT_TYPE_NAME