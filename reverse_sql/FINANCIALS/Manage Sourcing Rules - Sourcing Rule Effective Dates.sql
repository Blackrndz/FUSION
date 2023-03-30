/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-08-09  $:
 * $HeadURL:  $:
 * $Id: Manage Sourcing Rules - Sourcing Rule Effective Dates $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT  MscSourcingRules.SOURCING_RULE_NAME                      RES_NAME,
  ( SELECT distinct ParametersEO.Organization_Code
   FROM MSC_PARAMETERS ParametersEO
   WHERE ParametersEO.ORGANIZATION_ID =  MscSourcingRules.ORGANIZATION_ID   
  ) RES_ORGANIZATION_ASSIGNMENT,
  to_char(MscSrReceiptOrg.EFFECTIVE_DATE,'DD-Mon-YYYY')         RES_START_DATE,
  to_char(MscSrReceiptOrg.DISABLE_DATE,'DD-Mon-YYYY')           RES_END_DATE,
  MscSrReceiptOrg.LAST_UPDATED_BY 								RSC_LAST_UPDATED_BY
,MscSrReceiptOrg.LAST_UPDATE_DATE 								RSC_LAST_UPDATE_DATE
,MscSrReceiptOrg.CREATED_BY 									RSC_CREATED_BY
,MscSrReceiptOrg.CREATION_DATE 									RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,MscSourcingRules.ORGANIZATION_ID  RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM MSC_SOURCING_RULES MscSourcingRules
    ,MSC_SR_RECEIPT_ORG MscSrReceiptOrg
WHERE MscSourcingRules.SOURCING_RULE_ID = MscSrReceiptOrg.SOURCING_RULE_ID
