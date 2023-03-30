/* ****************************************************************************
* $Revision: 54688 $:
* $Author: dhara.pithadiya $:
* $Date: 2016-04-26 13:45:49 +0700 (Tue, 26 Apr 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/Manage%20Receivables%20Descriptive%20Flexfields%20-%20Manage%20Segment%20Labels.sql $:
* $Id: Manage Receivables Descriptive Flexfields - Manage Segment Labels.sql 53187 2016-03-01 11:52:21Z dhara.pithadiya
$:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT DescriptiveFlexfieldEO.NAME       AS RES_FLEXFIELD_NAME
,SegmentLabel.DESCRIPTIVE_FLEXFIELD_CODE AS RES_FLEXFIELD_CODE
,SegmentLabel.SEGMENT_LABEL_CODE         AS RES_SEGMENT_LABEL_CODE
,SegmentLabel.NAME                       AS RES_NAME
,SegmentLabel.DESCRIPTION                AS RES_DESCRIPTION
,SegmentLabel.BI_OBJECT_NAME             AS RES_BI_OBJECT_NAME
,SegmentLabel.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,SegmentLabel.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,SegmentLabel.CREATED_BY RSC_CREATED_BY
,SegmentLabel.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_DF_FLEXFIELDS_VL DescriptiveFlexfieldEO
,FND_DF_SEGMENT_LABELS_VL SegmentLabel
WHERE DescriptiveFlexfieldEO.DESCRIPTIVE_FLEXFIELD_CODE = SegmentLabel.DESCRIPTIVE_FLEXFIELD_CODE
AND(DescriptiveFlexfieldEO.module_id                   IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	INNER JOIN fnd_appl_taxonomy t
	ON rf.ancestor_module_id = t.module_id
	WHERE t.module_type      = 'LBA'
	AND t.module_key         = 'PrcPoCommonPo'
	))
ORDER BY RES_FLEXFIELD_NAME
,RES_SEGMENT_LABEL_CODE