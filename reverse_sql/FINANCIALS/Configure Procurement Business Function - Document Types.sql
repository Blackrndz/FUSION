/* ****************************************************************************
 * $Revision: 55346 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-05-23 14:11:43 +0700 (Mon, 23 May 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 55346 2016-05-23 07:11:43Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT BusinessUnitUsagePEO.BU_NAME RES_PROCUREMENT_BU
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES_VL
	WHERE LOOKUP_TYPE                                 = 'DOCUMENT_SUBTYPE'
	AND PurchasingDocumentTypeEO.DOCUMENT_SUBTYPE = LOOKUP_CODE	
	) RES_TYPE
,PurchasingDocumentTypeEO.TYPE_NAME RES_DISPLAY_NAME
,DECODE(PurchasingDocumentTypeEO.CO_TEMPLATE_ID,NULL,PurchasingDocumentTypeEO.DOCUMENT_TEMPLATE_CODE,NULL) RES_NEGOTIATION_LAYOUT
,PurchasingDocumentTypeEO.RESPONSE_TEMPLATE_CODE RES_RESPONSE_LAYOUT
,DECODE(PurchasingDocumentTypeEO.CO_TEMPLATE_ID,NULL,NULL,PurchasingDocumentTypeEO.DOCUMENT_TEMPLATE_CODE) RES_DOCUMENT_LAYOUT
,PurchasingDocumentTypeEO.CO_CONT_TERMS_LAYOUT_CODE RES_CONTRACT_TERMS_LAYOUT
/*,PurchasingDocumentTypeEO.CO_LAYOUT_TEMPLATE RES_CHANGE_ORDER_TEMPLATE*/
, (select distinct PurchasingChangeOrderTemplat1.TEMPLATE_NAME
  FROM PO_CO_TEMPLATES_VL PurchasingChangeOrderTemplat1 
  where PurchasingChangeOrderTemplat1.TYPE_LOOKUP_CODE  =  PurchasingDocumentTypeEO.DOCUMENT_SUBTYPE 
    and  PurchasingChangeOrderTemplat1.TEMPLATE_ID    =     PurchasingDocumentTypeEO.CO_TEMPLATE_ID) RES_CHANGE_ORDER_TEMPLATE

,PurchasingDocumentTypeEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,PurchasingDocumentTypeEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,PurchasingDocumentTypeEO.CREATED_BY  RSC_CREATED_BY
,PurchasingDocumentTypeEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,PurchasingSystemParameterEO.PRC_BU_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID
   
FROM PO_SYSTEM_PARAMETERS_ALL PurchasingSystemParameterEO
,FUN_BU_USAGES_V BusinessUnitUsagePEO
,PO_DOCUMENT_TYPES_VL PurchasingDocumentTypeEO
WHERE PurchasingSystemParameterEO.PRC_BU_ID               = BusinessUnitUsagePEO.BUSINESS_UNIT_ID
AND BusinessUnitUsagePEO.MODULE_ID                        = 110
AND BusinessUnitUsagePEO.MODULE_KEY                       = 'PROCUREMENT_BF'
AND PurchasingSystemParameterEO.PRC_BU_ID               = PurchasingDocumentTypeEO.PRC_BU_ID
ORDER BY BusinessUnitUsagePEO.BU_NAME
,PurchasingDocumentTypeEO.TYPE_NAME