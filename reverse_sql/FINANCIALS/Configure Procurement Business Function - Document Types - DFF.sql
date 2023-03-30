/* ****************************************************************************
 * $Revision: 53756 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-03-22 15:41:28 +0700 (Tue, 22 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Chart%20of%20Accounts%20Value%20Set%20Values%20-%20Manage%20Values.sql $:
 * $Id: Manage Chart of Accounts Value Set Values - Manage Values.sql 53756 2016-03-22 08:41:28Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- syntax: APPLICATION_ID##RES##DFF_CODE (Descriptive Flexfield name)
-- DFF_LOGIC_TO_APPLY=201##RES##PO_DOCUMENT_TYPES
-- DFF_ATTRIBUTES=ATTRIBUTE,ATTRIBUTE_DATE,ATTRIBUTE_NUMBER,ATTRIBUTE_TIMESTAMP

-- IMPORTANT: 
-- 	- the alias names for the Foreign keys must be the same as in the inventory.
--  - the alias name for context code must be RES_CONTEXT_CODE
--  - NO ALIASES for atributes fields.

SELECT BusinessUnitUsagePEO.BU_NAME RES_PROCUREMENT_BU
,(SELECT MEANING
	FROM FND_LOOKUP_VALUES_VL
	WHERE LOOKUP_TYPE                                 = 'DOCUMENT_SUBTYPE'
	AND PurchasingDocumentTypeEO.DOCUMENT_SUBTYPE = LOOKUP_CODE
	) RES_TYPE
,PurchasingDocumentTypeEO.ATTRIBUTE_CATEGORY RES_CONTEXT_CODE
,PurchasingDocumentTypeEO.ATTRIBUTE1
,PurchasingDocumentTypeEO.ATTRIBUTE2
,PurchasingDocumentTypeEO.ATTRIBUTE3
,PurchasingDocumentTypeEO.ATTRIBUTE4
,PurchasingDocumentTypeEO.ATTRIBUTE5
,PurchasingDocumentTypeEO.ATTRIBUTE6
,PurchasingDocumentTypeEO.ATTRIBUTE7
,PurchasingDocumentTypeEO.ATTRIBUTE8
,PurchasingDocumentTypeEO.ATTRIBUTE9
,PurchasingDocumentTypeEO.ATTRIBUTE10
,PurchasingDocumentTypeEO.ATTRIBUTE11
,PurchasingDocumentTypeEO.ATTRIBUTE12
,PurchasingDocumentTypeEO.ATTRIBUTE13
,PurchasingDocumentTypeEO.ATTRIBUTE14
,PurchasingDocumentTypeEO.ATTRIBUTE15
,PurchasingDocumentTypeEO.ATTRIBUTE16
,PurchasingDocumentTypeEO.ATTRIBUTE17
,PurchasingDocumentTypeEO.ATTRIBUTE18
,PurchasingDocumentTypeEO.ATTRIBUTE19
,PurchasingDocumentTypeEO.ATTRIBUTE20
,PurchasingDocumentTypeEO.ATTRIBUTE_DATE1
,PurchasingDocumentTypeEO.ATTRIBUTE_DATE2
,PurchasingDocumentTypeEO.ATTRIBUTE_DATE3
,PurchasingDocumentTypeEO.ATTRIBUTE_DATE4
,PurchasingDocumentTypeEO.ATTRIBUTE_DATE5
,PurchasingDocumentTypeEO.ATTRIBUTE_DATE6
,PurchasingDocumentTypeEO.ATTRIBUTE_DATE7
,PurchasingDocumentTypeEO.ATTRIBUTE_DATE8
,PurchasingDocumentTypeEO.ATTRIBUTE_DATE9
,PurchasingDocumentTypeEO.ATTRIBUTE_DATE10
,PurchasingDocumentTypeEO.ATTRIBUTE_NUMBER1
,PurchasingDocumentTypeEO.ATTRIBUTE_NUMBER2
,PurchasingDocumentTypeEO.ATTRIBUTE_NUMBER3
,PurchasingDocumentTypeEO.ATTRIBUTE_NUMBER4
,PurchasingDocumentTypeEO.ATTRIBUTE_NUMBER5
,PurchasingDocumentTypeEO.ATTRIBUTE_NUMBER6
,PurchasingDocumentTypeEO.ATTRIBUTE_NUMBER7
,PurchasingDocumentTypeEO.ATTRIBUTE_NUMBER8
,PurchasingDocumentTypeEO.ATTRIBUTE_NUMBER9
,PurchasingDocumentTypeEO.ATTRIBUTE_NUMBER10
,PurchasingDocumentTypeEO.ATTRIBUTE_TIMESTAMP1
,PurchasingDocumentTypeEO.ATTRIBUTE_TIMESTAMP2
,PurchasingDocumentTypeEO.ATTRIBUTE_TIMESTAMP3
,PurchasingDocumentTypeEO.ATTRIBUTE_TIMESTAMP4
,PurchasingDocumentTypeEO.ATTRIBUTE_TIMESTAMP5
,PurchasingDocumentTypeEO.ATTRIBUTE_TIMESTAMP6
,PurchasingDocumentTypeEO.ATTRIBUTE_TIMESTAMP7
,PurchasingDocumentTypeEO.ATTRIBUTE_TIMESTAMP8
,PurchasingDocumentTypeEO.ATTRIBUTE_TIMESTAMP9
,PurchasingDocumentTypeEO.ATTRIBUTE_TIMESTAMP10
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
AND (PurchasingDocumentTypeEO.ATTRIBUTE_CATEGORY IS NOT NULL OR
PurchasingDocumentTypeEO.ATTRIBUTE1 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE2 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE3 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE4 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE5 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE6 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE7 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE8 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE9 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE10 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE11 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE12 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE13 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE14 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE15 IS NOT NULL OR
PurchasingDocumentTypeEO.ATTRIBUTE16 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE17 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE18 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE19 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE20 IS NOT NULL OR
PurchasingDocumentTypeEO.ATTRIBUTE_DATE1 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_DATE2 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_DATE3 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_DATE4 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_DATE5 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_DATE6 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_DATE7 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_DATE8 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_DATE9 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_DATE10 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_NUMBER1 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_NUMBER2 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_NUMBER3 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_NUMBER4 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_NUMBER5 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_NUMBER6 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_NUMBER7 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_NUMBER8 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_NUMBER9 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_NUMBER10 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_TIMESTAMP1 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_TIMESTAMP2 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_TIMESTAMP3 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_TIMESTAMP4 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_TIMESTAMP5 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_TIMESTAMP6 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_TIMESTAMP7 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_TIMESTAMP8 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_TIMESTAMP9 IS NOT NULL OR 
PurchasingDocumentTypeEO.ATTRIBUTE_TIMESTAMP10 IS NOT NULL)
ORDER BY BusinessUnitUsagePEO.BU_NAME
,PurchasingDocumentTypeEO.TYPE_NAME