/* ****************************************************************************
 * $Revision: 62193 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2017-05-12 17:05:45 +0700 (Fri, 12 May 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13.18.10/trunk/core/reverse_sql/FINANCIALS/Manage%20Catalog%20Descriptive%20Flexfields%20-%20Segment%20Labels.sql $:
 * $Id: Manage Catalog Descriptive Flexfields - Segment Labels.sql 62193 2017-05-12 10:05:45Z pisan.jariyasettachok $:
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
    
FROM FND_DF_FLEXFIELDS_VL DescriptiveFlexfieldEO
,FND_DF_SEGMENT_LABELS_VL SegmentLabel
WHERE DescriptiveFlexfieldEO.DESCRIPTIVE_FLEXFIELD_CODE = SegmentLabel.DESCRIPTIVE_FLEXFIELD_CODE
AND(DescriptiveFlexfieldEO.module_id                   IN
	(SELECT rf.child_module_id
	FROM fnd_appl_taxonomy_rf rf
	INNER JOIN fnd_appl_taxonomy t
	ON rf.ancestor_module_id = t.module_id
	WHERE t.module_type      = 'APPLICATION'
	AND t.module_key         = 'PJC'
	))
ORDER BY RES_FLEXFIELD_NAME
,RES_SEGMENT_LABEL_CODE