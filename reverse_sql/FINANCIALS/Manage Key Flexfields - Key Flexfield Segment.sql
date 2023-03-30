/* ****************************************************************************
* $Revision: 78229 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
* $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Key%20Flexfields%20-%20Key%20Flexfield%20Segment.sql $:
* $Id: Manage Key Flexfields - Key Flexfield Segment.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */

SELECT
	(SELECT KEY_FLEXFIELD_CODE
	FROM FND_KF_STRUCTURES_VL
	WHERE STRUCTURE_ID = KeyFlexfieldSegmentEO.STRUCTURE_ID
	) AS RES_KEY_FLEXFIELD_CODE
,(SELECT NAME
	FROM FND_KF_FLEXFIELDS_VL
	WHERE KEY_FLEXFIELD_CODE =
		(SELECT KEY_FLEXFIELD_CODE
		FROM FND_KF_STRUCTURES_VL
		WHERE STRUCTURE_ID = KeyFlexfieldSegmentEO.STRUCTURE_ID
		)
	) AS RES_KEY_FLEXFIELD_NAME
/*,(SELECT USER_MODULE_NAME
	FROM FND_APPL_TAXONOMY_VL
	WHERE MODULE_ID =
		(SELECT MODULE_ID
		FROM FND_KF_FLEXFIELDS_VL
		WHERE KEY_FLEXFIELD_CODE =
			(SELECT KEY_FLEXFIELD_CODE
			FROM FND_KF_STRUCTURES_VL
			WHERE STRUCTURE_ID = KeyFlexfieldSegmentEO.STRUCTURE_ID
			)
		)
	) AS RES_MODULE*/
,(SELECT STRUCTURE_CODE
	FROM FND_KF_STRUCTURES_VL
	WHERE STRUCTURE_ID = KeyFlexfieldSegmentEO.STRUCTURE_ID
	)                                        AS RES_STRUCTURE_CODE
,KeyFlexfieldSegmentEO.SEGMENT_CODE       AS RES_SEGMENT_CODE
,KeyFlexfieldSegmentEO.SEGMENT_IDENTIFIER AS RES_API_NAME
,KeyFlexfieldSegmentEO.NAME               AS RES_NAME
,KeyFlexfieldSegmentEO.DESCRIPTION        AS RES_DESCRIPTION
,KeyFlexfieldSegmentEO.SEQUENCE_NUMBER    AS RES_SEQUENCE_NUMBER
,KeyFlexfieldSegmentEO.PROMPT             AS RES_PROMPT
,KeyFlexfieldSegmentEO.SHORT_PROMPT       AS RES_SHORT_PROMPT
,NVL((SELECT meaning
	FROM fnd_lookups
	WHERE lookup_type = 'YES_NO'
	AND lookup_code   = KeyFlexfieldSegmentEO.ENABLED_FLAG
	),'No')                                   AS RES_ENABLED
,KeyFlexfieldSegmentEO.DISPLAY_WIDTH AS RES_DISPLAY_WIDTH
,(SELECT MEANING
	FROM fnd_lookups
	WHERE LOOKUP_TYPE = 'FND_FF_SEGMENT_RANGE_TYPES'
	AND LOOKUP_CODE   = KeyFlexfieldSegmentEO.RANGE_TYPE
	)                                 AS RES_RANGE_TYPE
,KeyFlexfieldSegmentEO.COLUMN_NAME AS RES_COLUMN_NAME
,(SELECT VALUE_SET_CODE
	FROM FND_VS_VALUE_SETS
	WHERE VALUE_SET_ID = KeyFlexfieldSegmentEO.DEFAULT_VALUE_SET_ID
	) AS RES_DEFAULT_VALUE_SET_CODE
,KeyFlexfieldSegmentEO.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,KeyFlexfieldSegmentEO.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,KeyFlexfieldSegmentEO.CREATED_BY RSC_CREATED_BY
,KeyFlexfieldSegmentEO.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM FND_KF_SEGMENTS_VL KeyFlexfieldSegmentEO
ORDER BY RES_KEY_FLEXFIELD_CODE
,RES_STRUCTURE_CODE
,KeyFlexfieldSegmentEO.SEQUENCE_NUMBER