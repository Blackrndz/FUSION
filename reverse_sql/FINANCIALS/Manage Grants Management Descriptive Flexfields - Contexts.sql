/* ****************************************************************************
* $Revision: 53610 $:
* $Author: nasrullah.dusenmahamad $:
* $Date: 2016-10-31 11:01:59 +0700 (Thu, 17 Mar 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Cash%20Management%20Descriptive%20Flexfields%20-%20Manage%20Cash%20Management%20Descriptive%20Flexfields.sql $:
* $Id: Manage Requisition Descriptive Flexfields - Contexts.sql 53610 2016-03-17 04:01:59Z nasrullah.dusenmahamad $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT DescriptiveFlexfieldEO.NAME                        AS RES_FLEXFIELD_NAME
,DescriptiveFlexfieldContextE1.DESCRIPTIVE_FLEXFIELD_CODE AS RES_FLEXFIELD_CODE
,DescriptiveFlexfieldContextE1.NAME                       AS RES_DISPLAY_NAME
,DescriptiveFlexfieldContextE1.CONTEXT_CODE               AS RES_CONTEXT_CODE
,DescriptiveFlexfieldContextE1.CONTEXT_IDENTIFIER         AS RES_API_NAME
,DescriptiveFlexfieldContextE1.DESCRIPTION                AS RES_DESCRIPTION
,NVL(
	(SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = DescriptiveFlexfieldContextE1.ENABLED_FLAG
	),'No') AS RES_ENABLED
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
AND  DescriptiveFlexfieldContextE1.APPLICATION_ID           = 8402
AND DescriptiveFlexfieldEO.DESCRIPTIVE_FLEXFIELD_CODE        = DescriptiveFlexfieldContextE1.DESCRIPTIVE_FLEXFIELD_CODE
AND DescriptiveFlexfieldEO.FLEXFIELD_TYPE                    = 'DFF'
AND DescriptiveFlexfieldEO.bi_enabled_flag = 'Y'
ORDER BY RES_FLEXFIELD_NAME,CONTEXT_CODE
,RES_DISPLAY_NAME