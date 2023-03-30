/* ****************************************************************************
 * $Revision: 53543 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-03-15 15:46:40 +0700 (Tue, 15 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.12/trunk/core/reverse_sql/FINANCIALS/Manage%20Aging%20Periods%20-%20Aging%20Period.sql $:
 * $Id: Manage Aging Periods - Aging Period.sql 53543 2016-03-15 08:46:40Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT PoCoTemplatesTlE0.TEMPLATE_NAME RES_NAME
,PoCoTemplatesTlE0.DESCRIPTION RES_DESCRIPTION
,PoCoTemplatesBE0.CO_TEMPLATE_CODE RES_CODE
,(SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'PON_STATUS'
	AND LOOKUP_CODE = PoCoTemplatesBE0.STATUS
	) RES_STATUS
,NVL((SELECT MEANING
	FROM FND_LOOKUPS
	WHERE LOOKUP_TYPE = 'POR_DOCUMENT_TYPE'
	AND LOOKUP_CODE = PoCoTemplatesBE0.TYPE_LOOKUP_CODE
	),'Purchase Order') RES_DOCUMENT_TYPE
,PoCoTemplatesBE0.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,PoCoTemplatesBE0.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,PoCoTemplatesBE0.CREATED_BY  RSC_CREATED_BY
,PoCoTemplatesBE0.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PO_CO_TEMPLATES_TL PoCoTemplatesTlE0
,PO_CO_TEMPLATES_B PoCoTemplatesBE0
WHERE PoCoTemplatesTlE0.TEMPLATE_ID = PoCoTemplatesBE0.TEMPLATE_ID
AND PoCoTemplatesTlE0.LANGUAGE = USERENV('LANG')
ORDER BY PoCoTemplatesTlE0.TEMPLATE_NAME