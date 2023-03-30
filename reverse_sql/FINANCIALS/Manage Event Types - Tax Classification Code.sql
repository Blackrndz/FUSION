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
,(SELECT BU_NAME
	FROM FUN_ALL_BUSINESS_UNITS_V
	WHERE BU_ID = etClassificationsE0.ORG_ID 
	) RES_BUSINESS_UNIT
,etClassificationsE0.OUTPUT_TAX_CLASS_CODE RES_TAX_CLASSIFICATION_CODE
,etClassificationsE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,etClassificationsE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,etClassificationsE0.CREATED_BY  RSC_CREATED_BY
,etClassificationsE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,etClassificationsE0.ORG_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_EVENT_TYPES_VL eventTypesE0
,PJF_EVENT_TYPE_OUS_ALL etClassificationsE0
WHERE eventTypesE0.EVENT_TYPE_ID = etClassificationsE0.EVENT_TYPE_ID
ORDER BY eventTypesE0.EVENT_TYPE_NAME,2