/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Fixed%20Assets%20Key%20Flexfields%20-%20Manage%20Segment%20Labels.sql $:
* $Id: Manage Fixed Assets Key Flexfields - Manage Segment Labels.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT
	(SELECT KEY_FLEXFIELD_CODE
	FROM FND_KF_STRUCTURES_VL
	WHERE STRUCTURE_ID = SegmentLabel.STRUCTURE_ID
	) AS RES_KEY_FLEXFIELD_CODE
,(SELECT NAME
	FROM FND_KF_FLEXFIELDS_VL
	WHERE KEY_FLEXFIELD_CODE =
		(SELECT KEY_FLEXFIELD_CODE
		FROM FND_KF_STRUCTURES_VL
		WHERE STRUCTURE_ID = SegmentLabel.STRUCTURE_ID
		)
	) AS RES_KEY_FLEXFIELD_NAME
,(SELECT STRUCTURE_CODE
	FROM FND_KF_STRUCTURES_VL
	WHERE STRUCTURE_ID = SegmentLabel.STRUCTURE_ID
	)                         AS RES_STRUCTURE_CODE
,SegmentLabel.SEGMENT_CODE AS RES_SEGMENT_CODE
,SegmentLabelDetail.NAME AS RES_SELECTED_LABELS
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

FROM FND_KF_LABELED_SEGMENTS SegmentLabel
,FND_KF_SEGMENT_LABELS_TL SegmentLabelDetail
WHERE SegmentLabel.STRUCTURE_ID IN
	(SELECT STRUCTURE_ID
	FROM FND_KF_STRUCTURES_VL
	WHERE APPLICATION_ID = 140
	)
AND SegmentLabel.SEGMENT_LABEL_CODE = SegmentLabelDetail.SEGMENT_LABEL_CODE
AND SegmentLabelDetail.LANGUAGE = USERENV('LANG')
ORDER BY RES_KEY_FLEXFIELD_CODE
,RES_STRUCTURE_CODE
,SegmentLabel.SEGMENT_CODE