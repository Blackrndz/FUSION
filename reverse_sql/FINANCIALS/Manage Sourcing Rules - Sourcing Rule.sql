/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-08-09  $:
 * $HeadURL:  $:
 * $Id: Manage Sourcing Rules - Sourcing Rule $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 

SELECT   SOURCING_RULE_NAME                                                     RES_NAME,
  DESCRIPTION                                                                   RES_DESCRIPTION,
  decode( MscSourcingRules.ORGANIZATION_ID ,'','Global','Local')
  /*(select  meaning 
   from fnd_lookup_values 
   where view_application_id = 0 
   and language = userenv('LANG') 
   and lookup_type = 'MSC_SOURCING_GLOBAL_LOCAL'  
   and  LOOKUP_CODE = MscSourcingRules.SOURCING_RULE_TYPE            )    */                                             RES_ORGANIZATION_ASSIGNMENT_TY,
 ( SELECT distinct ParametersEO.Organization_Code
   FROM MSC_PARAMETERS ParametersEO
   WHERE ParametersEO.ORGANIZATION_ID =  MscSourcingRules.ORGANIZATION_ID   
  )                                                                             										RES_ORGANIZATION,
 NVL((SELECT  meaning
  FROM fnd_lookup_values
  WHERE view_application_id =0
  AND language              = userenv('LANG')
  AND lookup_type           = 'MSC_YES_NO'
  and LOOKUP_CODE   		=  MscSourcingRules.PLANNING_ACTIVE  ),'No')                                                      RES_PLANNING_ACTIVE,
 MscSourcingRules.LAST_UPDATED_BY 			RSC_LAST_UPDATED_BY
,MscSourcingRules.LAST_UPDATE_DATE 			RSC_LAST_UPDATE_DATE
,MscSourcingRules.CREATED_BY 				RSC_CREATED_BY
,MscSourcingRules.CREATION_DATE 			RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,(SELECT INV_ORG.ORGANIZATION_ID 
	FROM INV_ORG_PARAMETERS INV_ORG
	,MSC_PARAMETERS MSC_ORG
	WHERE INV_ORG.ORGANIZATION_CODE = MSC_ORG.ORGANIZATION_CODE
	AND MSC_ORG.ORGANIZATION_ID = MscSourcingRules.ORGANIZATION_ID
	) RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM MSC_SOURCING_RULES MscSourcingRules
