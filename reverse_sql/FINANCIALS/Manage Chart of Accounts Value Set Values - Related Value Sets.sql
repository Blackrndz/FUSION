/* ****************************************************************************
* $Revision: 61006 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2017-02-09 16:56:52 +0700 (Thu, 09 Feb 2017) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/Manage%20Transaction%20Types%20-%20Manage%20Transaction%20Types.sql $:
* $Id: Manage Supplier Registration Value Sets - Manage Value Set.sql 61006 2017-02-09 09:56:52Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */
--RSC_PREREQUISITE_OBJECTS=FND_VS_RELATED_SETS

SELECT ValueSetEO.VALUE_SET_CODE  RES_VALUE_SET_CODE
,relateVaulesetE0.VALUE_SET_CODE2 RES_RELATED_VALUE_SET_CODE
,DECODE(relateVaulesetE0.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,relateVaulesetE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,relateVaulesetE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,relateVaulesetE0.CREATED_BY RSC_CREATED_BY
,relateVaulesetE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_VS_VALUE_SETS ValueSetEO
,FND_VS_RELATED_SETS  relateVaulesetE0
WHERE ValueSetEO.VALUE_SET_CODE = relateVaulesetE0.VALUE_SET_CODE1
AND ValueSetEO.MODULE_ID   in   (SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,fnd_appl_taxonomy at
	WHERE at.module_type = 'APPLICATION'
	AND at.module_key    = 'GL'
	AND AT.MODULE_ID     = RF.ANCESTOR_MODULE_ID
	)
ORDER BY RES_VALUE_SET_CODE