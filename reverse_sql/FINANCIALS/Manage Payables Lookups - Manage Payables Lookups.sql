/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Payables%20Lookups%20-%20Manage%20Payables%20Lookups.sql $:
 * $Id: Manage Payables Lookups - Manage Payables Lookups.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */
 


select distinct LOOKUPTYPEEO.LOOKUP_TYPE RES_LOOKUP_TYPE
,LOOKUPTYPEEO.REFERENCE_GROUP_NAME  RES_REFERENCE_GROUP_NAME
,LOOKUPTYPEEO.MEANING RES_MEANING
,LOOKUPTYPEEO.DESCRIPTION RES_DESCRIPTION
,APPLTAXONOMYPEO.USER_MODULE_NAME RES_APPLICATION
,DECODE(LOOKUPTYPEEO.CUSTOMIZATION_LEVEL,'S','System','U','User','E','Extension') RES_CONFIGURATION_LEVEL
, LookupTypeEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
, LookupTypeEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
, LookupTypeEO.CREATED_BY  RSC_CREATED_BY
, LookupTypeEO.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID

FROM FND_LOOKUP_TYPES_VL LookupTypeEO
,FND_APPL_TAXONOMY_VL APPLTAXONOMYPEO
,FND_LOOKUP_VALUES_VL LOOKUPGENERICEO
where LOOKUPTYPEEO.MODULE_ID = APPLTAXONOMYPEO.MODULE_ID
AND(LookupTypeEO.MODULE_ID  IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,fnd_appl_taxonomy at
	where at.MODULE_TYPE = 'APPLICATION'
	AND at.module_key    = 'AP'
	AND at.module_id     = rf.ancestor_module_id
	))
and LOOKUPTYPEEO.LOOKUP_TYPE = LOOKUPGENERICEO.LOOKUP_TYPE(+)	
order by LOOKUPTYPEEO.LOOKUP_TYPE