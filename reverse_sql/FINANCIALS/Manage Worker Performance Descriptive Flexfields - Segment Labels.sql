/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Worker%20Performance%20Descriptive%20Flexfields%20-%20Segment%20Labels.sql $:
 * $Id: Manage Worker Performance Descriptive Flexfields - Segment Labels.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */

SELECT
	(SELECT NAME
	FROM FND_DF_FLEXFIELDS_VL
	WHERE DESCRIPTIVE_FLEXFIELD_CODE = SegmentLabel.DESCRIPTIVE_FLEXFIELD_CODE
	)                                       AS RES_FLEXFIELD_NAME
,SegmentLabel.DESCRIPTIVE_FLEXFIELD_CODE AS RES_FLEXFIELD_CODE
,SegmentLabel.SEGMENT_LABEL_CODE         AS RES_SEGMENT_LABEL_CODE
,SegmentLabel.NAME                       AS RES_NAME
,SegmentLabel.DESCRIPTION                AS RES_DESCRIPTION
,SegmentLabel.BI_OBJECT_NAME             AS RES_BI_OBJECT_NAME
,SegmentLabel.LAST_UPDATED_BY  AS RSC_LAST_UPDATED_BY
,SegmentLabel.LAST_UPDATE_DATE AS RSC_LAST_UPDATE_DATE
,SegmentLabel.CREATED_BY  RSC_CREATED_BY
,SegmentLabel.CREATION_DATE  RSC_CREATION_DATE
, null RSC_LEDGER_ID
, null RSC_CHART_OF_ACCOUNTS_ID
, null RSC_BUSINESS_UNIT_ID
, null RSC_LEGAL_ENTITY_ID
, null RSC_ORGANIZATION_ID
, null RSC_BUSINESS_GROUP_ID
, NULL RSC_ENTERPRISE_ID
, NULL RSC_COUNTRY_ID
    
FROM FND_DF_SEGMENT_LABELS_VL SegmentLabel
,FND_DF_FLEXFIELDS_VL DescriptiveFlexfieldEO
WHERE DescriptiveFlexfieldEO.DESCRIPTIVE_FLEXFIELD_CODE = SegmentLabel.DESCRIPTIVE_FLEXFIELD_CODE
AND SegmentLabel.APPLICATION_ID = 10020
AND(DescriptiveFlexfieldEO.module_id     IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	INNER JOIN fnd_appl_taxonomy t
	ON rf.ancestor_module_id = t.module_id
	WHERE t.module_type      = 'LBA'
	AND t.module_key         = 'HcmPerformanceTop'
	))
ORDER BY RES_FLEXFIELD_NAME
,RES_SEGMENT_LABEL_CODE