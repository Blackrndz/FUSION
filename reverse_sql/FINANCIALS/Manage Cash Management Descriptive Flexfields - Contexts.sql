/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Cash%20Management%20Descriptive%20Flexfields%20-%20Contexts.sql $:
* $Id: Manage Cash Management Descriptive Flexfields - Contexts.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
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
,DescriptiveFlexfieldContextE1.CREATED_BY  RSC_CREATED_BY
,DescriptiveFlexfieldContextE1.CREATION_DATE  RSC_CREATION_DATE
,DescriptiveFlexfieldContextE1.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,DescriptiveFlexfieldContextE1.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID
    
FROM FND_DF_CONTEXTS_VL DescriptiveFlexfieldContextE1
,FND_DF_FLEXFIELDS_VL DescriptiveFlexfieldEO
WHERE DescriptiveFlexfieldContextE1.APPLICATION_ID = 260
AND DescriptiveFlexfieldContextE1.CONTEXT_CODE NOT IN('Global Data Elements','Context Data Element')
AND DescriptiveFlexfieldEO.DESCRIPTIVE_FLEXFIELD_CODE        = DescriptiveFlexfieldContextE1.DESCRIPTIVE_FLEXFIELD_CODE
AND DescriptiveFlexfieldEO.FLEXFIELD_TYPE                    = 'DFF'
ORDER BY RES_FLEXFIELD_NAME
,RES_DISPLAY_NAME