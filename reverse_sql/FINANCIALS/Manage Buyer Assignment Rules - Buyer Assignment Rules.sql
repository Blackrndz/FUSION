/* ****************************************************************************
 * $Revision: 53537 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2016-03-15 15:01:41 +0700 (Tue, 15 Mar 2016) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Assign%20Legal%20Entities%20-%20Assign%20Legal%20Entities.sql $:
 * $Id: Assign Legal Entities - Assign Legal Entities.sql 53537 2016-03-15 08:01:41Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT /*+ FIRST_ROWS(10) */
BuyerAssignementRulesEO.RULE_SEQ_NUM RES_RULE_SEQUENCE
,RuleSetPEO.MEANING RES_RULE_SET
,BusinessUnitUsagePEO.BU_NAME RES_REQUISITIONING_BU
,NVL(BrowseCategoryPEO.CATEGORY_NAME,CategoryPEO.CATEGORY_NAME) RES_COMMODITY
,DeliverToOrgPEO.ORGANIZATION_NAME RES_DELIVER_TO_ORGANIZATION
,ProjectPEO.SEGMENT1 RES_PROJECT
,BuyerAssignementRulesEO.COST_CENTER RES_COST_CENTER
,SupplierNamePEO.VENDOR_NAME RES_SUPPLIER
,NonCatalogFlagPoLookupPEO.DISPLAYED_FIELD RES_NONCATALOG_REQUEST
,BuyerAssignementRulesEO.EXCEEDS_LINE_AMOUNT RES_EXCEEDS_LINE_AMOUNT
,GlLedgers.CURRENCY_CODE RES_CURRENCY
,PrcBusinessUnitUsagePEO.BU_NAME RES_PROCUREMENT_BU
,BuyerNameDPEO.LIST_NAME RES_BUYER_NAME
,EmailAddressPEO.EMAIL_ADDRESS RES_BUYER_E_MAIL
,BuyerAssignementRulesEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,BuyerAssignementRulesEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,BuyerAssignementRulesEO.CREATED_BY  RSC_CREATED_BY
,BuyerAssignementRulesEO.CREATION_DATE  RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,BuyerAssignementRulesEO.REQ_BU_ID RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,null RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PO_BUYER_ASSIGNMENT_RULES BuyerAssignementRulesEO
,FND_LOOKUPS RuleSetPEO
,INV_ORGANIZATION_DEFINITIONS_V DeliverToOrgPEO
,PJF_PROJECTS_ALL_VL ProjectPEO
,POZ_SUPPLIERS_V SupplierNamePEO
,PER_PERSON_NAMES_F_V BuyerNameDPEO
,EGP_CATEGORIES_VL CategoryPEO
,POR_BROWSE_CATEGORIES_VL BrowseCategoryPEO
,FUN_BU_USAGES_V BusinessUnitUsagePEO
,FUN_BU_USAGES_V PrcBusinessUnitUsagePEO
,PO_LOOKUP_CODES NonCatalogFlagPoLookupPEO
,FUN_ALL_BUSINESS_UNITS_V BU
,GL_LEDGERS GlLedgers
,PER_ALL_PEOPLE_F PersonDPEO
,PER_EMAIL_ADDRESSES EmailAddressPEO
WHERE(BuyerAssignementRulesEO.RULE_SET_CODE            = RuleSetPEO.LOOKUP_CODE (+)
AND 'PO_BUYER_ASSIGN_RULE_SETS'                        = RuleSetPEO.LOOKUP_TYPE (+))
AND(BuyerAssignementRulesEO.REQ_BU_ID                  = BusinessUnitUsagePEO.BUSINESS_UNIT_ID(+)
AND 'REQUISITIONING_BF'                                = BusinessUnitUsagePEO.MODULE_KEY(+))
AND(BuyerAssignementRulesEO.DELIVER_TO_ORGANIZATION_ID = DeliverToOrgPEO.ORGANIZATION_ID(+))
AND(BuyerAssignementRulesEO.PROJECT_ID                 = ProjectPEO.PROJECT_ID (+))
AND(BuyerAssignementRulesEO.VENDOR_ID                  = SupplierNamePEO.VENDOR_ID (+))
AND(BuyerAssignementRulesEO.NON_CATALOG_FLAG           = NonCatalogFlagPoLookupPEO.LOOKUP_CODE(+)
AND 'YES_NO'                                           = NonCatalogFlagPoLookupPEO.LOOKUP_TYPE(+))
AND(BuyerAssignementRulesEO.PRC_BU_ID                  = PrcBusinessUnitUsagePEO.BUSINESS_UNIT_ID(+)
AND 'PROCUREMENT_BF'                                   = PrcBusinessUnitUsagePEO.MODULE_KEY(+))
AND(BuyerAssignementRulesEO.BUYER_ID                   = BuyerNameDPEO.PERSON_ID (+))
AND(BuyerAssignementRulesEO.COMMODITY_ID               = CategoryPEO.CATEGORY_ID(+)
AND BuyerAssignementRulesEO.COMMODITY_ID               = BrowseCategoryPEO.CATEGORY_ID(+)
AND BrowseCategoryPEO.CATEGORY_ID(+) NOT              IN(0,1,2))
AND(BusinessUnitUsagePEO.BUSINESS_UNIT_ID              = BU.BU_ID(+))
AND(BU.PRIMARY_LEDGER_ID                               = GlLedgers.LEDGER_ID(+))
AND BuyerAssignementRulesEO.BUYER_ID   = PersonDPEO.PERSON_ID
AND SYSDATE BETWEEN PersonDPEO.EFFECTIVE_START_DATE AND PersonDPEO.EFFECTIVE_END_DATE
AND(EmailAddressPEO.EMAIL_ADDRESS_ID (+) = PersonDPEO.PRIMARY_EMAIL_ID)
ORDER BY BuyerAssignementRulesEO.RULE_SEQ_NUM