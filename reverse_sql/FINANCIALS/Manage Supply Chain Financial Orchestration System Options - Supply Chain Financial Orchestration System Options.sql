/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-10-11  $:
 * $HeadURL:  $:
 * $Id: Manage Supply Chain Financial Orchestration System Options - Supply Chain Financial Orchestration System Options.sql  $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

 -- RSC_PREREQUISITE_OBJECTS=FOS_SYSTEM_OPTIONS 
 
SELECT 
 OrgOrganizationDefinitionsPE1.ORGANIZATION_CODE                               RES_ITEM_VALIDATION_ORGANIZATI,
 OrgOrganizationDefinitionsPE1.ORGANIZATION_NAME                               RES_ORGANIZATION_NAME,
 ItemPEO.ITEM_NUMBER                                                           RES_SERVICE_ITEM,
 ItemPEO.DESCRIPTION                                                           RES_SERVICE_ITEM_DESCRIPTION,
 SystemOptionsEO.PAYLOAD_SIZE                                            	   RES_MAXIMUM_NUMBER_OF_RECORDS_,
 decode(SystemOptionsEO.MULTI_FTR_FLAG,'Y','Yes','No')                     RES_SEPARATE_PRIMARY_AND_FINAN,
  SystemOptionsEO.LAST_UPDATED_BY  		RSC_LAST_UPDATED_BY
  ,SystemOptionsEO.LAST_UPDATE_DATE  	RSC_LAST_UPDATE_DATE
  ,SystemOptionsEO.CREATED_BY  			RSC_CREATED_BY
  ,SystemOptionsEO.CREATION_DATE  		RSC_CREATION_DATE
  ,null 								RSC_LEDGER_ID
  ,OrgOrganizationDefinitionsPE1.CHART_OF_ACCOUNTS_ID 				RSC_CHART_OF_ACCOUNTS_ID
  ,OrgOrganizationDefinitionsPE1.BUSINESS_UNIT_ID 					RSC_BUSINESS_UNIT_ID
  ,OrgOrganizationDefinitionsPE1.LEGAL_ENTITY 						RSC_LEGAL_ENTITY_ID
  ,OrgOrganizationDefinitionsPE1.ORGANIZATION_ID 					RSC_ORGANIZATION_ID
  ,OrgOrganizationDefinitionsPE1.BUSINESS_GROUP_ID 					RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID


FROM FOS_SYSTEM_OPTIONS SystemOptionsEO,
  INV_ORGANIZATION_DEFINITIONS_V OrgOrganizationDefinitionsPE1,
  EGP_SYSTEM_ITEMS_VL ItemPEO
WHERE SystemOptionsEO.VALIDATION_ORGANIZATION_ID = OrgOrganizationDefinitionsPE1.ORGANIZATION_ID
AND SystemOptionsEO.SERVICE_ITEM_ID           = ItemPEO.INVENTORY_ITEM_ID(+)
AND SystemOptionsEO.VALIDATION_ORGANIZATION_ID = ItemPEO.ORGANIZATION_ID(+)


