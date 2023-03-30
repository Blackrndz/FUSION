/* ****************************************************************************
 * $Revision:  $:
 * $Author: Nasrullah Dusenmahamad $:
 * $Date: 2017-03-17 $:
 * $HeadURL: $:
 * $Id: Manage Category Descriptive Flexfields - Segment Labels $:
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
WHERE SegmentLabel.APPLICATION_ID = 10011
AND SegmentLabel.DESCRIPTIVE_FLEXFIELD_CODE = 'EGP_ITEM_REVISIONS_DFF'
ORDER BY RES_FLEXFIELD_NAME
,RES_SEGMENT_LABEL_CODE