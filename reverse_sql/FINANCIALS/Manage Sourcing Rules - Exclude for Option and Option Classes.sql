/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-08-18  $:
 * $HeadURL:  $:
 * $Id: Manage Sourcing Rules - Exclude for Option and Option Classes $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 
-- RSC_PREREQUISITE_OBJECTS=MSC_SR_SOURCE_ORG_EXCLUDES

SELECT MscSourcingRules.SOURCING_RULE_NAME RES_NAME
,( SELECT distinct ParametersEO.Organization_Code
   FROM MSC_PARAMETERS ParametersEO
   WHERE ParametersEO.ORGANIZATION_ID =  MscSourcingRules.ORGANIZATION_ID) RES_ORGANIZATION_ASSIGNMENT
,TO_CHAR(MscSrReceiptOrg.EFFECTIVE_DATE,'DD-Mon-YYYY') RES_START_DATE
,(select  meaning 
	from fnd_lookup_values 
	where view_application_id = 0 
	and language = userenv('LANG') 
	and lookup_type = 'MSC_SOURCING_SOURCE_TYPE'  
	and  LOOKUP_CODE =  MscSrSourceOrg.SOURCE_TYPE 
	) RES_TYPE
,(SELECT ParametersEO.Organization_Code
	FROM MSC_PARAMETERS ParametersEO
	WHERE ParametersEO.ORGANIZATION_ID =  MscSrSourceOrg.SOURCE_ORGANIZATION_ID   
	) RES_ORGANIZATION
,(SELECT  GlobalTradingPartnerEO.PARTNER_NAME
	FROM MSC_GLOBAL_TRADING_PARTNERS GlobalTradingPartnerEO
	WHERE  GlobalTradingPartnerEO.TP_ID       = MscSrSourceOrg.SOURCE_PARTNER_ID
	) RES_SUPPLIER
,(select TradingPartnerSiteEO.TP_SITE_CODE
	FROM MSC_TRADING_PARTNER_SITES TradingPartnerSiteEO
	WHERE TradingPartnerSiteEO.PARTNER_SITE_ID = MscSrSourceOrg.SOURCE_PARTNER_SITE_ID    
	) RES_SUPPLIER_SITE
,nvl(MscSrSourceOrg.ALLOCATION_PERCENT, 0) RES_ALLOCATION_PERCENT
,nvl(MscSrSourceOrg.RANK, -1) RES_RANK
,(SELECT ITEM_NAME
	FROM MSC_ITEMS
	WHERE INVENTORY_ITEM_ID = MscExcludes.INVENTORY_ITEM_ID
	) RES_OPTION_AND_OPTION_CLASSES
,MscSrSourceOrg.LAST_UPDATED_BY 			RSC_LAST_UPDATED_BY
,MscSrSourceOrg.LAST_UPDATE_DATE 			RSC_LAST_UPDATE_DATE
,MscSrSourceOrg.CREATED_BY 					RSC_CREATED_BY
,MscSrSourceOrg.CREATION_DATE 				RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,(SELECT INV_ORG.ORGANIZATION_ID 
	FROM INV_ORG_PARAMETERS INV_ORG
	,MSC_PARAMETERS MSC_ORG
	WHERE INV_ORG.ORGANIZATION_CODE = MSC_ORG.ORGANIZATION_CODE
	AND MSC_ORG.ORGANIZATION_ID = MscSrSourceOrg.SOURCE_ORGANIZATION_ID
	) RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM MSC_SR_SOURCE_ORG MscSrSourceOrg
,MSC_SR_RECEIPT_ORG MscSrReceiptOrg
,MSC_SOURCING_RULES MscSourcingRules
,MSC_SR_SOURCE_ORG_EXCLUDES MscExcludes
WHERE MscSrSourceOrg.sr_receipt_id = MscSrReceiptOrg.sr_receipt_id
and MscSourcingRules.SOURCING_RULE_ID = MscSrReceiptOrg.SOURCING_RULE_ID
AND MscSrSourceOrg.SR_SR_SOURCE_ID = MscExcludes.SR_SOURCE_ID
ORDER BY RES_NAME,RES_START_DATE