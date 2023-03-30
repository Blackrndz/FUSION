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

--BIP_BATCH_SIZE=40000
--NO_REMOVE_COMMENTS
--RSC_PREREQUISITE_OBJECTS=FND_VS_RELATED_VALUES

SELECT /*+ PARALLEL(8) */ ValueSetEO.VALUE_SET_CODE  RES_VALUE_SET_CODE
,relateVaulE0.VALUE_SET_CODE2 RES_RELATED_VALUE_SET_CODE
,(SELECT VALUE
	FROM FND_VS_VALUES_B
	WHERE VALUE_ID = relateVaulE0.VALUE_ID1
	AND ENTERPRISE_ID = relateVaulE0.ENTERPRISE_ID
	) RES_VALUE
,(SELECT DESCRIPTION
	FROM FND_VS_VALUES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND VALUE_ID = relateVaulE0.VALUE_ID1
	AND ENTERPRISE_ID = relateVaulE0.ENTERPRISE_ID
	) RES_DESCRIPTION
,DECODE(relateVaulE0.ENABLED_FLAG,'Y','Yes','No') RES_ENABLED
,(SELECT VALUE
	FROM FND_VS_VALUES_B
	WHERE VALUE_ID = relateVaulE0.VALUE_ID2
	AND ENTERPRISE_ID = relateVaulE0.ENTERPRISE_ID
	) RES_RELATED_VALUE
,(SELECT DESCRIPTION
	FROM FND_VS_VALUES_TL
	WHERE LANGUAGE = USERENV('LANG')
	AND VALUE_ID = relateVaulE0.VALUE_ID2
	AND ENTERPRISE_ID = relateVaulE0.ENTERPRISE_ID
	) RES_RELATED_DESCRIPTION
,relateVaulE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,relateVaulE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,relateVaulE0.CREATED_BY RSC_CREATED_BY
,relateVaulE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_VS_VALUE_SETS ValueSetEO
,FND_VS_RELATED_SETS relateVaulesetE0
,FND_VS_RELATED_VALUES relateVaulE0
WHERE ValueSetEO.VALUE_SET_CODE = relateVaulesetE0.VALUE_SET_CODE1
AND relateVaulesetE0.VALUE_SET_CODE1 = relateVaulE0.VALUE_SET_CODE1
AND relateVaulesetE0.VALUE_SET_CODE2 = relateVaulE0.VALUE_SET_CODE2
AND relateVaulesetE0.ENTERPRISE_ID = relateVaulE0.ENTERPRISE_ID
AND relateVaulesetE0.SANDBOX_ID = relateVaulE0.SANDBOX_ID
AND relateVaulesetE0.ORA_SEED_SET1 = relateVaulE0.ORA_SEED_SET1
AND ValueSetEO.MODULE_ID   in (SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	,fnd_appl_taxonomy at
	WHERE at.module_type = 'APPLICATION'
	AND at.module_key    = 'GL'
	AND AT.MODULE_ID     = RF.ANCESTOR_MODULE_ID)