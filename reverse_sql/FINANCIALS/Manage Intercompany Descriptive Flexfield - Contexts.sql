/* ****************************************************************************
* $Revision:  $:
* $Author: Nasrullah Dusenmahamad $:
* $Date: 2017-04-18 $:
* $HeadURL: $:
* $Id: Manage Shipping Descriptive Flexfields - Contexts.sql $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT DescriptiveFlexfieldEO.NAME                        AS RES_FLEXFIELD_NAME
,DescriptiveFlexfieldContextE1.DESCRIPTIVE_FLEXFIELD_CODE AS RES_FLEXFIELD_CODE
,DescriptiveFlexfieldContextE1.NAME                       AS RES_DISPLAY_NAME
,DescriptiveFlexfieldContextE1.CONTEXT_CODE               AS RES_CONTEXT_CODE
,DescriptiveFlexfieldContextE1.CONTEXT_IDENTIFIER         AS RES_API_NAME
,DescriptiveFlexfieldContextE1.DESCRIPTION                AS RES_DESCRIPTION
,(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = NVL(DescriptiveFlexfieldContextE1.ENABLED_FLAG,'No')
	) AS RES_ENABLED
,DescriptiveFlexfieldContextE1.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,DescriptiveFlexfieldContextE1.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,DescriptiveFlexfieldContextE1.CREATED_BY RSC_CREATED_BY
,DescriptiveFlexfieldContextE1.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_DF_CONTEXTS_VL DescriptiveFlexfieldContextE1
,FND_DF_FLEXFIELDS_VL DescriptiveFlexfieldEO
WHERE DescriptiveFlexfieldContextE1.CONTEXT_CODE NOT IN('Global Data Elements','Context Data Element')
AND DescriptiveFlexfieldEO.DESCRIPTIVE_FLEXFIELD_CODE        = DescriptiveFlexfieldContextE1.DESCRIPTIVE_FLEXFIELD_CODE
AND DescriptiveFlexfieldEO.FLEXFIELD_TYPE                    = 'DFF'
AND(DescriptiveFlexfieldEO.module_id     IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	INNER JOIN fnd_appl_taxonomy t
	ON rf.ancestor_module_id = t.module_id
	WHERE t.module_type      = 'APPLICATION'
	AND t.module_key         = 'FUN'
	))
ORDER BY RES_FLEXFIELD_NAME
,RES_DISPLAY_NAME