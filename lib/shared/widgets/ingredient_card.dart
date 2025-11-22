import 'package:flutter/material.dart';
import 'package:zeroeat/models.dart';

class IngredientCard extends StatelessWidget {
  final Ingredient ingredient;

  const IngredientCard({
    super.key,
    required this.ingredient,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '영양정보 (1일 영양성분 기준치에 대한 비율)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF3E2F1C),
          )
        ),
        const SizedBox(height: 8),
        _dailyIntakeIndicator("칼로리(Kcal)", ingredient.kcal.toDouble(), 2000),
        _dailyIntakeIndicator("당류(g)", ingredient.sugarG, 50),
        _dailyIntakeIndicator("나트륨(mg)", ingredient.sodiumMg, 2000),
        _dailyIntakeIndicator("지방(g)", ingredient.fatG, 70),
        _dailyIntakeIndicator("단백질(g)", ingredient.proteinG, 50),
        const SizedBox(height: 16),
        if (ingredient.warningIngredients != null && ingredient.warningIngredients.isNotEmpty) ...[
          Row(
            children: [
              const Text(
                '주의 성분',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3E2F1C),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.info_outline, size: 16, color: Color(0xFF3E2F1C)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('주의 성분 안내'),
                        content: const Text(
                          '- 말티톨 : 과다 섭취 시 설사 유발 가능, 혈당을 올리기 때문에 당뇨 환자에게 주의 필요\n\n- 아스파탐 : 인슐린 수치증가, 페닐케톤뇨증 환자는 섭취 금지\n\n- 수크랄로스 : 장내 유익균 감소, 과다 섭취 시 복통 및 설사 유발 가능\n\n- 아세설팜칼륨 : 과다 섭취 시 두통, 어지러움 유발 가능'
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('닫기'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          ...ingredient.warningIngredients.map<Widget>((igd) => 
            Text(
              igd,
              style: const TextStyle(color: Colors.red)
            )
          )
        ]
      ],
    );
  }
}

Widget _dailyIntakeIndicator(String label, double value, double maxValue) {
  final percentage = (value / maxValue);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 89,
          child: Text(
            '$label: $value',
            style: const TextStyle(fontSize: 12),
          ),
        ),

        const SizedBox(width: 5),

        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.all( Radius.circular(8)),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: const Color.fromARGB(15, 0, 0, 0),
              color:  const Color(0xFF2F5D50),
              minHeight: 15,
            ),
          ),
        )
      ],
    )
  ); 
}